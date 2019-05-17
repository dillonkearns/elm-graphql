module Example08Foldr exposing (main)

import Github.Object
import Github.Object.Repository as Repository
import Github.Object.StargazerConnection
import Github.Query as Query
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)


type alias Response =
    Int


query : SelectionSet Response RootQuery
query =
    SelectionSet.foldl (+)
        0
        ([ { owner = "dillonkearns", name = "mobster" }
         , { owner = "dillonkearns", name = "elm-graphql" }
         , { owner = "dillonkearns", name = "elm-typescript-interop" }
         ]
            |> List.map (\args -> Query.repository args stargazerCount)
            |> List.map SelectionSet.nonNullOrFail
        )


stargazerCount : SelectionSet Int Github.Object.Repository
stargazerCount =
    Repository.stargazers identity Github.Object.StargazerConnection.totalCount


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


init : () -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading
    , makeRequest
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


type alias Flags =
    ()


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
