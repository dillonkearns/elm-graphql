module Api.Enum.CommentCannotUpdateReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


type CommentCannotUpdateReason
    = INSUFFICIENT_ACCESS
    | LOCKED
    | LOGIN_REQUIRED
    | MAINTENANCE
    | VERIFIED_EMAIL_REQUIRED


decoder : Decoder CommentCannotUpdateReason
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "INSUFFICIENT_ACCESS" ->
                        Decode.succeed INSUFFICIENT_ACCESS

                    "LOCKED" ->
                        Decode.succeed LOCKED

                    "LOGIN_REQUIRED" ->
                        Decode.succeed LOGIN_REQUIRED

                    "MAINTENANCE" ->
                        Decode.succeed MAINTENANCE

                    "VERIFIED_EMAIL_REQUIRED" ->
                        Decode.succeed VERIFIED_EMAIL_REQUIRED

                    _ ->
                        Decode.fail ("Invalid CommentCannotUpdateReason type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
