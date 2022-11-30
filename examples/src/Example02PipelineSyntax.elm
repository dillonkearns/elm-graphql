module Example02PipelineSyntax exposing (main)

import CustomScalarCodecs
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Interface.Character as Character
import Swapi.Query as Query


type alias Response =
    Character


type alias Character =
    { name : String
    , id : CustomScalarCodecs.Id
    , friends : List String
    }



{-
   You could use `SelectionSet.map3 Character` here instead of `succeed`.

   The tradeoffs, in a nutshell:
   *mapN*
   - Better error messages (pipeline errors can be confusing, and the compiler has more to work with when you use mapN so it can be more precise)
   - Don't have to use `with`
   - Better IDE support (it knows you need to pass in exactly N items)

   *succeed*
   - You don't change `map2` -> `map3` when you add a new field
   - You can go beyond 8 items
-}


query : SelectionSet Response RootQuery
query =
    -- We use `identity` to say that we aren't giving any
    -- optional arguments to `hero`. Read this blog post for more:
    -- https://medium.com/@zenitram.oiram/graphqelm-optional-arguments-in-a-language-without-optional-arguments-d8074ca3cf74
    Query.hero identity
        (SelectionSet.succeed Character
            |> with Character.name
            |> with Character.id
            |> with (Character.friends Character.name)
        )


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)



-- Elm Architecture Setup


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading, makeRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
