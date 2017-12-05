module Api.Enum.IssueOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type IssueOrderField
    = CREATED_AT
    | UPDATED_AT
    | COMMENTS


decoder : Decoder IssueOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "UPDATED_AT" ->
                        Decode.succeed UPDATED_AT

                    "COMMENTS" ->
                        Decode.succeed COMMENTS

                    _ ->
                        Decode.fail ("Invalid IssueOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
