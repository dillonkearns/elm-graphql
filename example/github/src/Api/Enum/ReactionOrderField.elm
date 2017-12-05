module Api.Enum.ReactionOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


type ReactionOrderField
    = CREATED_AT


decoder : Decoder ReactionOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    _ ->
                        Decode.fail ("Invalid ReactionOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
