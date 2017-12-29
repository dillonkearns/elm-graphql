module Github.Enum.StatusState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible commit status states.

  - EXPECTED - Status is expected.
  - ERROR - Status is errored.
  - FAILURE - Status is failing.
  - PENDING - Status is pending.
  - SUCCESS - Status is successful.

-}
type StatusState
    = EXPECTED
    | ERROR
    | FAILURE
    | PENDING
    | SUCCESS


decoder : Decoder StatusState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "EXPECTED" ->
                        Decode.succeed EXPECTED

                    "ERROR" ->
                        Decode.succeed ERROR

                    "FAILURE" ->
                        Decode.succeed FAILURE

                    "PENDING" ->
                        Decode.succeed PENDING

                    "SUCCESS" ->
                        Decode.succeed SUCCESS

                    _ ->
                        Decode.fail ("Invalid StatusState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
