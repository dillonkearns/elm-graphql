module Github.Enum.DeploymentState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states in which a deployment can be.

  - ABANDONED - The pending deployment was not updated after 30 minutes.
  - ACTIVE - The deployment is currently active.
  - DESTROYED - An inactive transient deployment.
  - ERROR - The deployment experienced an error.
  - FAILURE - The deployment has failed.
  - INACTIVE - The deployment is inactive.
  - PENDING - The deployment is pending.

-}
type DeploymentState
    = ABANDONED
    | ACTIVE
    | DESTROYED
    | ERROR
    | FAILURE
    | INACTIVE
    | PENDING


decoder : Decoder DeploymentState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ABANDONED" ->
                        Decode.succeed ABANDONED

                    "ACTIVE" ->
                        Decode.succeed ACTIVE

                    "DESTROYED" ->
                        Decode.succeed DESTROYED

                    "ERROR" ->
                        Decode.succeed ERROR

                    "FAILURE" ->
                        Decode.succeed FAILURE

                    "INACTIVE" ->
                        Decode.succeed INACTIVE

                    "PENDING" ->
                        Decode.succeed PENDING

                    _ ->
                        Decode.fail ("Invalid DeploymentState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : DeploymentState -> String
toString enum =
    case enum of
        ABANDONED ->
            "ABANDONED"

        ACTIVE ->
            "ACTIVE"

        DESTROYED ->
            "DESTROYED"

        ERROR ->
            "ERROR"

        FAILURE ->
            "FAILURE"

        INACTIVE ->
            "INACTIVE"

        PENDING ->
            "PENDING"
