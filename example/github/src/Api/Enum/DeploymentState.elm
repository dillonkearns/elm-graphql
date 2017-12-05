module Api.Enum.DeploymentState exposing (..)

import Json.Decode as Decode exposing (Decoder)


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
