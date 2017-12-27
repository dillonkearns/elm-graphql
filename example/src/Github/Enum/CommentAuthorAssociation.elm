module Github.Enum.CommentAuthorAssociation exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
