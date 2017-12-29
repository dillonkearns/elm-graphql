module Github.Enum.TeamPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible team privacy values.

  - SECRET - A secret team can only be seen by its members.
  - VISIBLE - A visible team can be seen and @mentioned by every member of the organization.

-}
type TeamPrivacy
    = SECRET
    | VISIBLE


decoder : Decoder TeamPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "SECRET" ->
                        Decode.succeed SECRET

                    "VISIBLE" ->
                        Decode.succeed VISIBLE

                    _ ->
                        Decode.fail ("Invalid TeamPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
