module Normalize.Enum.Episode_ exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| One of the films in the Star Wars Trilogy

  - Empire - Released in 1980.
  - Jedi_ - Released in 1983.
  - Newhope_ - Released in 1977.

-}
type Episode_
    = Empire
    | Jedi_
    | Newhope_


decoder : Decoder Episode_
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "empire" ->
                        Decode.succeed Empire

                    "jedi_" ->
                        Decode.succeed Jedi_

                    "_newhope" ->
                        Decode.succeed Newhope_

                    _ ->
                        Decode.fail ("Invalid Episode_ type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : Episode_ -> String
toString enum =
    case enum of
        Empire ->
            "empire"

        Jedi_ ->
            "jedi_"

        Newhope_ ->
            "_newhope"
