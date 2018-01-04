module Github.Enum.RepositoryPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The privacy of a repository

  - PUBLIC - Public
  - PRIVATE - Private

-}
type RepositoryPrivacy
    = PUBLIC
    | PRIVATE


decoder : Decoder RepositoryPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PUBLIC" ->
                        Decode.succeed PUBLIC

                    "PRIVATE" ->
                        Decode.succeed PRIVATE

                    _ ->
                        Decode.fail ("Invalid RepositoryPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryPrivacy -> String
toString enum =
    case enum of
        PUBLIC ->
            "PUBLIC"

        PRIVATE ->
            "PRIVATE"
