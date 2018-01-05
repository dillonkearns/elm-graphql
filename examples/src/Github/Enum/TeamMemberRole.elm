module Github.Enum.TeamMemberRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible team member roles; either 'maintainer' or 'member'.

  - Maintainer - A team maintainer has permission to add and remove team members.
  - Member - A team member has no administrative permissions on the team.

-}
type TeamMemberRole
    = Maintainer
    | Member


decoder : Decoder TeamMemberRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MAINTAINER" ->
                        Decode.succeed Maintainer

                    "MEMBER" ->
                        Decode.succeed Member

                    _ ->
                        Decode.fail ("Invalid TeamMemberRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : TeamMemberRole -> String
toString enum =
    case enum of
        Maintainer ->
            "MAINTAINER"

        Member ->
            "MEMBER"
