module Github.Enum.PullRequestState exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible states of a pull request.

  - OPEN - A pull request that is still open.
  - CLOSED - A pull request that has been closed without being merged.
  - MERGED - A pull request that has been closed by being merged.

-}
type PullRequestState
    = OPEN
    | CLOSED
    | MERGED


decoder : Decoder PullRequestState
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "OPEN" ->
                        Decode.succeed OPEN

                    "CLOSED" ->
                        Decode.succeed CLOSED

                    "MERGED" ->
                        Decode.succeed MERGED

                    _ ->
                        Decode.fail ("Invalid PullRequestState type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
