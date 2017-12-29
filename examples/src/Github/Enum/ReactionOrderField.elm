module Github.Enum.ReactionOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| A list of fields that reactions can be ordered by.

  - CREATED_AT - Allows ordering a list of reactions by when they were created.

-}
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
