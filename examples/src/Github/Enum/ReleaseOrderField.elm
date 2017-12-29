module Github.Enum.ReleaseOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which release connections can be ordered.

  - CREATED_AT - Order releases by creation time
  - NAME - Order releases alphabetically by name

-}
type ReleaseOrderField
    = CREATED_AT
    | NAME


decoder : Decoder ReleaseOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "NAME" ->
                        Decode.succeed NAME

                    _ ->
                        Decode.fail ("Invalid ReleaseOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
