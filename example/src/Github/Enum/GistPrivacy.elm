module Github.Enum.GistPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


type GistPrivacy
    = PUBLIC
    | SECRET
    | ALL


decoder : Decoder GistPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PUBLIC" ->
                        Decode.succeed PUBLIC

                    "SECRET" ->
                        Decode.succeed SECRET

                    "ALL" ->
                        Decode.succeed ALL

                    _ ->
                        Decode.fail ("Invalid GistPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
