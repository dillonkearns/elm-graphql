module Github.Enum.RepositoryPermission exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The access level to a repository

  - ADMIN - Can read, clone, push, and add collaborators
  - WRITE - Can read, clone and push
  - READ - Can read and clone

-}
type RepositoryPermission
    = ADMIN
    | WRITE
    | READ


decoder : Decoder RepositoryPermission
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed ADMIN

                    "WRITE" ->
                        Decode.succeed WRITE

                    "READ" ->
                        Decode.succeed READ

                    _ ->
                        Decode.fail ("Invalid RepositoryPermission type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
