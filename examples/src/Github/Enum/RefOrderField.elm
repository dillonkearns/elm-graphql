module Github.Enum.RefOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which ref connections can be ordered.

  - TagCommitDate - Order refs by underlying commit date if the ref prefix is refs/tags/
  - Alphabetical - Order refs by their alphanumeric name

-}
type RefOrderField
    = TagCommitDate
    | Alphabetical


decoder : Decoder RefOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "TAG_COMMIT_DATE" ->
                        Decode.succeed TagCommitDate

                    "ALPHABETICAL" ->
                        Decode.succeed Alphabetical

                    _ ->
                        Decode.fail ("Invalid RefOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RefOrderField -> String
toString enum =
    case enum of
        TagCommitDate ->
            "TAG_COMMIT_DATE"

        Alphabetical ->
            "ALPHABETICAL"
