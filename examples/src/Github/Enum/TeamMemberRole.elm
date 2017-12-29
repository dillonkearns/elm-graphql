module Github.Enum.TeamMemberRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible team member roles; either 'maintainer' or 'member'.

  - MAINTAINER - A team maintainer has permission to add and remove team members.
  - MEMBER - A team member has no administrative permissions on the team.

-}
type TeamMemberRole
    = MAINTAINER
    | MEMBER


decoder : Decoder TeamMemberRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MAINTAINER" ->
                        Decode.succeed MAINTAINER

                    "MEMBER" ->
                        Decode.succeed MEMBER

                    _ ->
                        Decode.fail ("Invalid TeamMemberRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
