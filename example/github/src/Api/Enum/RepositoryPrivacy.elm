module Api.Enum.RepositoryPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


type RepositoryPrivacy
    = PUBLIC
    | PRIVATE


decoder : Decoder RepositoryPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PUBLIC" ->
                        Decode.succeed PUBLIC

                    "PRIVATE" ->
                        Decode.succeed PRIVATE

                    _ ->
                        Decode.fail ("Invalid RepositoryPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
