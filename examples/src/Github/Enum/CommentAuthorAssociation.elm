module Github.Enum.CommentAuthorAssociation exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| A comment author association with repository.

  - MEMBER - Author is a member of the organization that owns the repository.
  - OWNER - Author is the owner of the repository.
  - COLLABORATOR - Author has been invited to collaborate on the repository.
  - CONTRIBUTOR - Author has previously committed to the repository.
  - FIRST_TIME_CONTRIBUTOR - Author has not previously committed to the repository.
  - FIRST_TIMER - Author has not previously committed to GitHub.
  - NONE - Author has no association with the repository.

-}
type CommentAuthorAssociation
    = MEMBER
    | OWNER
    | COLLABORATOR
    | CONTRIBUTOR
    | FIRST_TIME_CONTRIBUTOR
    | FIRST_TIMER
    | NONE


decoder : Decoder CommentAuthorAssociation
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MEMBER" ->
                        Decode.succeed MEMBER

                    "OWNER" ->
                        Decode.succeed OWNER

                    "COLLABORATOR" ->
                        Decode.succeed COLLABORATOR

                    "CONTRIBUTOR" ->
                        Decode.succeed CONTRIBUTOR

                    "FIRST_TIME_CONTRIBUTOR" ->
                        Decode.succeed FIRST_TIME_CONTRIBUTOR

                    "FIRST_TIMER" ->
                        Decode.succeed FIRST_TIMER

                    "NONE" ->
                        Decode.succeed NONE

                    _ ->
                        Decode.fail ("Invalid CommentAuthorAssociation type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : CommentAuthorAssociation -> String
toString enum =
    case enum of
        MEMBER ->
            "MEMBER"

        OWNER ->
            "OWNER"

        COLLABORATOR ->
            "COLLABORATOR"

        CONTRIBUTOR ->
            "CONTRIBUTOR"

        FIRST_TIME_CONTRIBUTOR ->
            "FIRST_TIME_CONTRIBUTOR"

        FIRST_TIMER ->
            "FIRST_TIMER"

        NONE ->
            "NONE"
