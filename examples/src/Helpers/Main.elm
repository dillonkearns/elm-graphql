module Helpers.Main exposing (Program, document)

import Browser
import DateFormat exposing (text)
import Html exposing (Html, a, div, h1, input, label, p, pre, text)
import Html.Attributes exposing (href, type_)
import Html.Events exposing (onClick)
import PrintAny
import Regex


type alias Program flags subModel subMsg =
    Platform.Program flags (Model subModel) (Msg subMsg)


type Msg subMsg
    = ToggleAliases
    | SubMsg subMsg


type alias Model subModel =
    { subModel : subModel
    , hideAliases : Bool
    }


document :
    { init : flags -> ( subModel, Cmd subMsg )
    , update : subMsg -> subModel -> ( subModel, Cmd subMsg )
    , queryString : String
    }
    -> Program flags subModel subMsg
document { init, update, queryString } =
    Browser.document
        { init = mapInit init
        , update = mapUpdate update
        , subscriptions = \_ -> Sub.none
        , view = view queryString
        }


mapInit : (flags -> ( subModel, Cmd subMsg )) -> flags -> ( Model subModel, Cmd (Msg subMsg) )
mapInit subInit flags =
    subInit flags
        |> Tuple.mapFirst (\subModel -> { subModel = subModel, hideAliases = True })
        |> Tuple.mapSecond (Cmd.map SubMsg)


mapUpdate : (subMsg -> subModel -> ( subModel, Cmd subMsg )) -> Msg subMsg -> Model subModel -> ( Model subModel, Cmd (Msg subMsg) )
mapUpdate subUpdate msg model =
    case msg of
        ToggleAliases ->
            ( { model | hideAliases = not model.hideAliases }, Cmd.none )

        SubMsg subMsg ->
            let
                ( a, b ) =
                    subUpdate subMsg model.subModel
            in
            ( { model | subModel = a }, b |> Cmd.map SubMsg )


view : String -> Model a -> Browser.Document (Msg subMsg)
view query model =
    { title = "Query Explorer"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , p [] [ toggleAliasesCheckbox ]
                , pre []
                    [ (if model.hideAliases then
                        query
                            |> stripAliases

                       else
                        query
                      )
                        |> text
                    ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , model.subModel |> PrintAny.view
                ]
            ]
        ]
    }


toggleAliasesCheckbox : Html (Msg subMsg)
toggleAliasesCheckbox =
    label []
        [ input [ type_ "checkbox", onClick ToggleAliases ] []
        , text " Show Aliases "
        , a [ href "https://github.com/dillonkearns/elm-graphql/blob/master/FAQ.md#how-do-field-aliases-work-in-dillonkearnselm-graphql" ]
            [ text "(?)"
            ]
        ]


stripAliases : String -> String
stripAliases query =
    query
        |> Regex.replace
            (Regex.fromStringWith { multiline = True, caseInsensitive = True } "^(\\s*)\\w+: "
                |> Maybe.withDefault Regex.never
            )
            (\match -> match.submatches |> List.head |> Maybe.withDefault Nothing |> Maybe.withDefault "")
