module Api.Enum.SortOrder exposing (..)

import Json.Decode as Decode exposing (Decoder)


type SortOrder
    = ASC
    | DESC
decoder : Decoder SortOrder
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ASC" ->
                        Decode.succeed ASC

                    "DESC" ->
                        Decode.succeed DESC

                    _ ->
                        Decode.fail ("Invalid Weather type, " ++ string ++ " try re-running the graphqelm CLI ")
        )
        