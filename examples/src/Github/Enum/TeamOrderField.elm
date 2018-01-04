module Github.Enum.TeamOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which team connections can be ordered.

  - NAME - Allows ordering a list of teams by name.

-}
type TeamOrderField
    = NAME


decoder : Decoder TeamOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "NAME" ->
                        Decode.succeed NAME

                    _ ->
                        Decode.fail ("Invalid TeamOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : TeamOrderField -> String
toString enum =
    case enum of
        NAME ->
            "NAME"
