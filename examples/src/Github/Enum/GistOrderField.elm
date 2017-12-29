module Github.Enum.GistOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which gist connections can be ordered.

  - CREATED_AT - Order gists by creation time
  - UPDATED_AT - Order gists by update time
  - PUSHED_AT - Order gists by push time

-}
type GistOrderField
    = CREATED_AT
    | UPDATED_AT
    | PUSHED_AT


decoder : Decoder GistOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "UPDATED_AT" ->
                        Decode.succeed UPDATED_AT

                    "PUSHED_AT" ->
                        Decode.succeed PUSHED_AT

                    _ ->
                        Decode.fail ("Invalid GistOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
