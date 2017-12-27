module Github.Enum.TeamOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
