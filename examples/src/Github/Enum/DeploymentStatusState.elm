module Github.Enum.DeploymentStatusState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states for a deployment status.

  - PENDING - The deployment is pending.
  - SUCCESS - The deployment was successful.
  - FAILURE - The deployment has failed.
  - INACTIVE - The deployment is inactive.
  - ERROR - The deployment experienced an error.

-}
type DeploymentStatusState
    = PENDING
    | SUCCESS
    | FAILURE
    | INACTIVE
    | ERROR


decoder : Decoder DeploymentStatusState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PENDING" ->
                        Decode.succeed PENDING

                    "SUCCESS" ->
                        Decode.succeed SUCCESS

                    "FAILURE" ->
                        Decode.succeed FAILURE

                    "INACTIVE" ->
                        Decode.succeed INACTIVE

                    "ERROR" ->
                        Decode.succeed ERROR

                    _ ->
                        Decode.fail ("Invalid DeploymentStatusState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
