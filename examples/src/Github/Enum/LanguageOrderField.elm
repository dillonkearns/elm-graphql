module Github.Enum.LanguageOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which language connections can be ordered.

  - SIZE - Order languages by the size of all files containing the language

-}
type LanguageOrderField
    = SIZE


decoder : Decoder LanguageOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "SIZE" ->
                        Decode.succeed SIZE

                    _ ->
                        Decode.fail ("Invalid LanguageOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
