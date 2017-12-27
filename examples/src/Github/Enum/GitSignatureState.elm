module Github.Enum.GitSignatureState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type GitSignatureState
    = VALID
    | INVALID
    | MALFORMED_SIG
    | UNKNOWN_KEY
    | BAD_EMAIL
    | UNVERIFIED_EMAIL
    | NO_USER
    | UNKNOWN_SIG_TYPE
    | UNSIGNED
    | GPGVERIFY_UNAVAILABLE
    | GPGVERIFY_ERROR
    | NOT_SIGNING_KEY
    | EXPIRED_KEY


decoder : Decoder GitSignatureState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "VALID" ->
                        Decode.succeed VALID

                    "INVALID" ->
                        Decode.succeed INVALID

                    "MALFORMED_SIG" ->
                        Decode.succeed MALFORMED_SIG

                    "UNKNOWN_KEY" ->
                        Decode.succeed UNKNOWN_KEY

                    "BAD_EMAIL" ->
                        Decode.succeed BAD_EMAIL

                    "UNVERIFIED_EMAIL" ->
                        Decode.succeed UNVERIFIED_EMAIL

                    "NO_USER" ->
                        Decode.succeed NO_USER

                    "UNKNOWN_SIG_TYPE" ->
                        Decode.succeed UNKNOWN_SIG_TYPE

                    "UNSIGNED" ->
                        Decode.succeed UNSIGNED

                    "GPGVERIFY_UNAVAILABLE" ->
                        Decode.succeed GPGVERIFY_UNAVAILABLE

                    "GPGVERIFY_ERROR" ->
                        Decode.succeed GPGVERIFY_ERROR

                    "NOT_SIGNING_KEY" ->
                        Decode.succeed NOT_SIGNING_KEY

                    "EXPIRED_KEY" ->
                        Decode.succeed EXPIRED_KEY

                    _ ->
                        Decode.fail ("Invalid GitSignatureState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
