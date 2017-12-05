module Api.Enum.ReactionContent exposing (..)

import Json.Decode as Decode exposing (Decoder)


type ReactionContent
    = THUMBS_UP
    | THUMBS_DOWN
    | LAUGH
    | HOORAY
    | CONFUSED
    | HEART


decoder : Decoder ReactionContent
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "THUMBS_UP" ->
                        Decode.succeed THUMBS_UP

                    "THUMBS_DOWN" ->
                        Decode.succeed THUMBS_DOWN

                    "LAUGH" ->
                        Decode.succeed LAUGH

                    "HOORAY" ->
                        Decode.succeed HOORAY

                    "CONFUSED" ->
                        Decode.succeed CONFUSED

                    "HEART" ->
                        Decode.succeed HEART

                    _ ->
                        Decode.fail ("Invalid ReactionContent type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
