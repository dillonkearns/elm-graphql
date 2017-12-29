module Github.Enum.OrderDirection exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Possible directions in which to order a list of items when provided an `orderBy` argument.

  - ASC - Specifies an ascending order for a given `orderBy` argument.
  - DESC - Specifies a descending order for a given `orderBy` argument.

-}
type OrderDirection
    = ASC
    | DESC


decoder : Decoder OrderDirection
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ASC" ->
                        Decode.succeed ASC

                    "DESC" ->
                        Decode.succeed DESC

                    _ ->
                        Decode.fail ("Invalid OrderDirection type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
