module Api.Enum.SortOrder exposing (..)

import Json.Decode as Decode exposing (Decoder)


type SortOrder
    = ASC
    | DESC


toString : SortOrder -> String
toString sortOrder =
    case sortOrder of
        ASC ->
            "ASC"

        DESC ->
            "DESC"


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
                        Decode.fail ("Invalid SortOrder type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
