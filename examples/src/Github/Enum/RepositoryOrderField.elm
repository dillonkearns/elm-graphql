module Github.Enum.RepositoryOrderField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| Properties by which repository connections can be ordered.

  - CREATED_AT - Order repositories by creation time
  - UPDATED_AT - Order repositories by update time
  - PUSHED_AT - Order repositories by push time
  - NAME - Order repositories by name
  - STARGAZERS - Order repositories by number of stargazers

-}
type RepositoryOrderField
    = CREATED_AT
    | UPDATED_AT
    | PUSHED_AT
    | NAME
    | STARGAZERS


decoder : Decoder RepositoryOrderField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "CREATED_AT" ->
                        Decode.succeed CREATED_AT

                    "UPDATED_AT" ->
                        Decode.succeed UPDATED_AT

                    "PUSHED_AT" ->
                        Decode.succeed PUSHED_AT

                    "NAME" ->
                        Decode.succeed NAME

                    "STARGAZERS" ->
                        Decode.succeed STARGAZERS

                    _ ->
                        Decode.fail ("Invalid RepositoryOrderField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryOrderField -> String
toString enum =
    case enum of
        CREATED_AT ->
            "CREATED_AT"

        UPDATED_AT ->
            "UPDATED_AT"

        PUSHED_AT ->
            "PUSHED_AT"

        NAME ->
            "NAME"

        STARGAZERS ->
            "STARGAZERS"
