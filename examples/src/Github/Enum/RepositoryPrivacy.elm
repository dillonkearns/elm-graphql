module Github.Enum.RepositoryPrivacy exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The privacy of a repository

  - Public - Public
  - Private - Private

-}
type RepositoryPrivacy
    = Public
    | Private


decoder : Decoder RepositoryPrivacy
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "PUBLIC" ->
                        Decode.succeed Public

                    "PRIVATE" ->
                        Decode.succeed Private

                    _ ->
                        Decode.fail ("Invalid RepositoryPrivacy type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryPrivacy -> String
toString enum =
    case enum of
        Public ->
            "PUBLIC"

        Private ->
            "PRIVATE"
