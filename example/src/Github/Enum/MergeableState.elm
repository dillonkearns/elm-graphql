module Github.Enum.MergeableState exposing (..)

import Json.Decode as Decode exposing (Decoder)


type MergeableState
    = MERGEABLE
    | CONFLICTING
    | UNKNOWN


decoder : Decoder MergeableState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MERGEABLE" ->
                        Decode.succeed MERGEABLE

                    "CONFLICTING" ->
                        Decode.succeed CONFLICTING

                    "UNKNOWN" ->
                        Decode.succeed UNKNOWN

                    _ ->
                        Decode.fail ("Invalid MergeableState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
