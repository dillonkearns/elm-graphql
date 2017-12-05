module Api.Enum.TeamMembershipType exposing (..)

import Json.Decode as Decode exposing (Decoder)


type TeamMembershipType
    = IMMEDIATE
    | CHILD_TEAM
    | ALL


decoder : Decoder TeamMembershipType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "IMMEDIATE" ->
                        Decode.succeed IMMEDIATE

                    "CHILD_TEAM" ->
                        Decode.succeed CHILD_TEAM

                    "ALL" ->
                        Decode.succeed ALL

                    _ ->
                        Decode.fail ("Invalid TeamMembershipType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
