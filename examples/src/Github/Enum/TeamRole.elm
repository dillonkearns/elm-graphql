module Github.Enum.TeamRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The role of a user on a team.

  - ADMIN - User has admin rights on the team.
  - MEMBER - User is a member of the team.

-}
type TeamRole
    = ADMIN
    | MEMBER


decoder : Decoder TeamRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed ADMIN

                    "MEMBER" ->
                        Decode.succeed MEMBER

                    _ ->
                        Decode.fail ("Invalid TeamRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
