module Github.Enum.GitSignatureState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The state of a Git signature.

  - VALID - Valid signature and verified by GitHub.
  - INVALID - Invalid signature.
  - MALFORMED_SIG - Malformed signature.
  - UNKNOWN_KEY - Key used for signing not known to GitHub.
  - BAD_EMAIL - Invalid email used for signing.
  - UNVERIFIED_EMAIL - Email used for signing unverified on GitHub.
  - NO_USER - Email used for signing not known to GitHub.
  - UNKNOWN_SIG_TYPE - Unknown signature type.
  - UNSIGNED - Unsigned.
  - GPGVERIFY_UNAVAILABLE - Internal error - the GPG verification service is unavailable at the moment.
  - GPGVERIFY_ERROR - Internal error - the GPG verification service misbehaved.
  - NOT_SIGNING_KEY - The usage flags for the key that signed this don't allow signing.
  - EXPIRED_KEY - Signing key expired.

-}
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
