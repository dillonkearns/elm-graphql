module Github.Enum.CommentCannotUpdateReason exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible errors that will prevent a user from updating a comment.

  - INSUFFICIENT_ACCESS - You must be the author or have write access to this repository to update this comment.
  - LOCKED - Unable to create comment because issue is locked.
  - LOGIN_REQUIRED - You must be logged in to update this comment.
  - MAINTENANCE - Repository is under maintenance.
  - VERIFIED_EMAIL_REQUIRED - At least one email address must be verified to update this comment.

-}
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


toString : CommentCannotUpdateReason -> String
toString enum =
    case enum of
        INSUFFICIENT_ACCESS ->
            "INSUFFICIENT_ACCESS"

        LOCKED ->
            "LOCKED"

        LOGIN_REQUIRED ->
            "LOGIN_REQUIRED"

        MAINTENANCE ->
            "MAINTENANCE"

        VERIFIED_EMAIL_REQUIRED ->
            "VERIFIED_EMAIL_REQUIRED"
