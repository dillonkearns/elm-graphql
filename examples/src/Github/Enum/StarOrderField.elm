module Github.Enum.StarOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which star connections can be ordered.

  - STARRED_AT - Allows ordering a list of stars by when they were created.

-}
type StarOrderField
    = STARRED_AT


decoder : Decoder StarOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "STARRED_AT" ->
                        Decode.succeed STARRED_AT

                    _ ->
                        Decode.fail ("Invalid StarOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : StarOrderField -> String
toString enum =
    case enum of
        STARRED_AT ->
            "STARRED_AT"
