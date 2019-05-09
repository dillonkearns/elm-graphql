port module Main exposing (main)

import Browser
import Graphql.Document
import Graphql.Operation exposing (RootSubscription)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Hasura.Object
import Hasura.Object.Author as Author
import Hasura.Subscription as Subscription
import Html exposing (Html, div, h1, h3, img, li, text, ul)
import Html.Attributes exposing (class, src)
import Html.Keyed as Keyed
import Json.Decode exposing (Decoder, field, int, string)
import Json.Encode as Encode
import RemoteData exposing (RemoteData)



--- Subscription document


subscriptionDocument : SelectionSet Authors RootSubscription
subscriptionDocument =
    Subscription.author identity authorSelection


authorSelection : SelectionSet Author Hasura.Object.Author
authorSelection =
    SelectionSet.map2 Author
        Author.id
        Author.name



---
---- MODEL ----


type alias Model =
    { authors : AuthorsData
    }


type alias Author =
    { id : Int
    , name : String
    }


type alias Authors =
    List Author


type alias AuthorsData =
    RemoteData Json.Decode.Error Authors



-- Initialize app state


initialize : Model
initialize =
    { authors = RemoteData.NotAsked
    }


init : ( Model, Cmd Msg )
init =
    ( initialize
    , Cmd.batch
        [ createSubscriptionToAuthors (subscriptionDocument |> Graphql.Document.serializeSubscription) ]
    )



---- Ports ----


port createSubscriptionToAuthors : String -> Cmd msg


port subscribingToAuthor : (Bool -> msg) -> Sub msg


port gotAuthorsData : (Json.Decode.Value -> msg) -> Sub msg



---- Subscriptions ----


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ gotAuthorsData AuthorDataReceived
        , subscribingToAuthor Loading
        ]



---- UPDATE ----


type Msg
    = Loading Bool
    | AuthorDataReceived Json.Decode.Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AuthorDataReceived data ->
            let
                remoteData =
                    Json.Decode.decodeValue (subscriptionDocument |> Graphql.Document.decoder) data |> RemoteData.fromResult
            in
            ( { model | authors = remoteData }, Cmd.none )

        Loading status ->
            case status of
                True ->
                    ( { model | authors = RemoteData.Loading }, Cmd.none )

                False ->
                    ( model, Cmd.none )



---- VIEW ----


viewAuthorItem : Author -> Html Msg
viewAuthorItem author =
    li [] <|
        [ text author.name ]


viewAuthorsList : Author -> ( String, Html Msg )
viewAuthorsList author =
    ( String.fromInt author.id, viewAuthorItem author )


viewAuthorsData : AuthorsData -> Html Msg
viewAuthorsData authorsData =
    div [] <|
        case authorsData of
            RemoteData.NotAsked ->
                [ text "" ]

            RemoteData.Loading ->
                [ div [ class "loading" ]
                    [ text "Loading list of authors ..."
                    ]
                ]

            RemoteData.Success authors ->
                case List.length authors of
                    0 ->
                        [ div [ class "empty_authors" ]
                            [ text "No authors found!"
                            ]
                        ]

                    _ ->
                        [ Keyed.ul [] <|
                            List.map viewAuthorsList authors
                        ]

            RemoteData.Failure err ->
                [ div [ class "error" ]
                    [ text ("Error fetching author: " ++ Json.Decode.errorToString err) ]
                ]


view : Model -> Html Msg
view model =
    div [ class "authors_wrapper" ]
        [ h3 []
            [ text "Authors"
            ]
        , viewAuthorsData model.authors
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
