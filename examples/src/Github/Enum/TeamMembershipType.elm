module Github.Enum.TeamMembershipType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Defines which types of team members are included in the returned list. Can be one of IMMEDIATE, CHILD_TEAM or ALL.

  - IMMEDIATE - Includes only immediate members of the team.
  - CHILD_TEAM - Includes only child team members for the team.
  - ALL - Includes immediate and child team members for the team.

-}
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
