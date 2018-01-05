module Github.Enum.TeamRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The role of a user on a team.

  - Admin - User has admin rights on the team.
  - Member - User is a member of the team.

-}
type TeamRole
    = Admin
    | Member


decoder : Decoder TeamRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed Admin

                    "MEMBER" ->
                        Decode.succeed Member

                    _ ->
                        Decode.fail ("Invalid TeamRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : TeamRole -> String
toString enum =
    case enum of
        Admin ->
            "ADMIN"

        Member ->
            "MEMBER"
