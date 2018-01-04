module Github.Enum.IssueOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which issue connections can be ordered.

  - CREATED_AT - Order issues by creation time
  - UPDATED_AT - Order issues by update time
  - COMMENTS - Order issues by comment count

-}
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


toString : IssueOrderField -> String
toString enum =
    case enum of
        CREATED_AT ->
            "CREATED_AT"

        UPDATED_AT ->
            "UPDATED_AT"

        COMMENTS ->
            "COMMENTS"
