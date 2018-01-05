module Github.Enum.TeamPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible team privacy values.

  - Secret - A secret team can only be seen by its members.
  - Visible - A visible team can be seen and @mentioned by every member of the organization.

-}
type TeamPrivacy
    = Secret
    | Visible


decoder : Decoder TeamPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "SECRET" ->
                        Decode.succeed Secret

                    "VISIBLE" ->
                        Decode.succeed Visible

                    _ ->
                        Decode.fail ("Invalid TeamPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : TeamPrivacy -> String
toString enum =
    case enum of
        Secret ->
            "SECRET"

        Visible ->
            "VISIBLE"
