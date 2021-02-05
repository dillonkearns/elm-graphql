module ConflictingSelections exposing (main)

import Browser
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, hardcoded, with)
import Html exposing (div, h1, p, pre, text)
import Normalize.InputObject
import Normalize.Object.Cat as Cat
import Normalize.Object.Dog as Dog
import Normalize.Object.ListId as ListId
import Normalize.Object.MaybeId as MaybeId
import Normalize.Query as Query
import Normalize.Scalar as Scalar
import Normalize.Union.ConflictingTypesUnion
import PrintAny
import RemoteData exposing (RemoteData)


type alias Response =
    ()


query : SelectionSet Response RootQuery
query =
    Query.conflictingTypesUnion
        (Normalize.Union.ConflictingTypesUnion.fragments
            { onDog = ignoreValue Dog.id
            , onCat = ignoreValue Cat.id
            , onListId = ignoreValue ListId.id
            , onMaybeId = ignoreValue MaybeId.id
            }
        )


ignoreValue : SelectionSet decodesTo scope -> SelectionSet () scope
ignoreValue =
    SelectionSet.map (\_ -> ())


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "http://elm-graphql-normalize.herokuapp.com"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


init : ( Model, Cmd Msg )
init =
    ( RemoteData.Loading
    , makeRequest
    )


view : Model -> Html.Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.serializeQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , model |> PrintAny.view
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
