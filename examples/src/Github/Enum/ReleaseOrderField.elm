module Github.Enum.ReleaseOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which release connections can be ordered.

  - CreatedAt - Order releases by creation time
  - Name - Order releases alphabetically by name

-}
type ReleaseOrderField
    = CreatedAt
    | Name


decoder : Decoder ReleaseOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CreatedAt

                    "NAME" ->
                        Decode.succeed Name

                    _ ->
                        Decode.fail ("Invalid ReleaseOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : ReleaseOrderField -> String
toString enum =
    case enum of
        CreatedAt ->
            "CREATED_AT"

        Name ->
            "NAME"
