module Helpers.Main exposing (Msg, document, view)

import Browser
import DateFormat exposing (text)
import Html exposing (div, h1, input, label, p, pre, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (onClick)
import PrintAny
import Regex


type Msg subMsg
    = ToggleAliases
    | SubMsg subMsg


document :
    { init : flags -> ( model, Cmd subMsg )
    , update : subMsg -> model -> ( model, Cmd subMsg )
    , queryString : String
    }
    -> Program flags model (Msg subMsg)
document { init, update, queryString } =
    Browser.document
        { init = mapInit init
        , update = mapUpdate update
        , subscriptions = \_ -> Sub.none
        , view = view queryString
        }


mapInit : (flags -> ( subModel, Cmd subMsg )) -> flags -> ( subModel, Cmd (Msg subMsg) )
mapInit subInit flags =
    subInit flags
        |> Tuple.mapSecond (Cmd.map SubMsg)


mapUpdate : (subMsg -> subModel -> ( subModel, Cmd subMsg )) -> Msg subMsg -> subModel -> ( subModel, Cmd (Msg subMsg) )
mapUpdate subUpdate msg subModel =
    case msg of
        ToggleAliases ->
            ( subModel, Cmd.none )

        SubMsg subMsg ->
            subUpdate subMsg subModel
                |> Tuple.mapSecond (Cmd.map SubMsg)


view : String -> a -> Browser.Document (Msg subMsg)
view query model =
    { title = "Query Explorer"
    , body =
        [ div []
            [ div []
                [ h1 [] [ text "Generated Query" ]
                , p [] [ toggleAliasesCheckbox ]
                , pre []
                    [ query
                        |> stripAliases
                        |> text
                    ]
                ]
            , div []
                [ h1 [] [ text "Response" ]
                , model |> PrintAny.view
                ]
            ]
        ]
    }


toggleAliasesCheckbox =
    label []
        [ input [ type_ "checkbox", onClick ToggleAliases ] []
        , text "Toggle Aliases"
        ]


stripAliases query =
    query
        |> Regex.replace
            (Regex.fromStringWith { multiline = True, caseInsensitive = True } "^(\\s*)\\w+: "
                |> Maybe.withDefault Regex.never
            )
            (\match -> match.submatches |> List.head |> Maybe.withDefault Nothing |> Maybe.withDefault "")
