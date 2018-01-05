module Github.Enum.TeamOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which team connections can be ordered.

  - Name - Allows ordering a list of teams by name.

-}
type TeamOrderField
    = Name


decoder : Decoder TeamOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "NAME" ->
                        Decode.succeed Name

                    _ ->
                        Decode.fail ("Invalid TeamOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : TeamOrderField -> String
toString enum =
    case enum of
        Name ->
            "NAME"
