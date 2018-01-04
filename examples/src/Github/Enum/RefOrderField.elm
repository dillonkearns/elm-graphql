module Github.Enum.RefOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which ref connections can be ordered.

  - TAG_COMMIT_DATE - Order refs by underlying commit date if the ref prefix is refs/tags/
  - ALPHABETICAL - Order refs by their alphanumeric name

-}
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


toString : RefOrderField -> String
toString enum =
    case enum of
        TAG_COMMIT_DATE ->
            "TAG_COMMIT_DATE"

        ALPHABETICAL ->
            "ALPHABETICAL"
