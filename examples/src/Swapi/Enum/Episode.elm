module Swapi.Enum.Episode exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| One of the films in the Star Wars Trilogy

  - EMPIRE - Released in 1980.
  - JEDI - Released in 1983.
  - NEWHOPE - Released in 1977.

-}
type Episode
    = EMPIRE
    | JEDI
    | NEWHOPE


decoder : Decoder Episode
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "EMPIRE" ->
                        Decode.succeed EMPIRE

                    "JEDI" ->
                        Decode.succeed JEDI

                    "NEWHOPE" ->
                        Decode.succeed NEWHOPE

                    _ ->
                        Decode.fail ("Invalid Episode type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
