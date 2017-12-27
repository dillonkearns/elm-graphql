module Github.Enum.RefOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RefOrderField
    = TAG_COMMIT_DATE
    | ALPHABETICAL


decoder : Decoder RefOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "TAG_COMMIT_DATE" ->
                        Decode.succeed TAG_COMMIT_DATE

                    "ALPHABETICAL" ->
                        Decode.succeed ALPHABETICAL

                    _ ->
                        Decode.fail ("Invalid RefOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
