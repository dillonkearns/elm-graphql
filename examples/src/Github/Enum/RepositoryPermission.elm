module Github.Enum.RepositoryPermission exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The access level to a repository

  - Admin - Can read, clone, push, and add collaborators
  - Write - Can read, clone and push
  - Read - Can read and clone

-}
type RepositoryPermission
    = Admin
    | Write
    | Read


decoder : Decoder RepositoryPermission
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "ADMIN" ->
                        Decode.succeed Admin

                    "WRITE" ->
                        Decode.succeed Write

                    "READ" ->
                        Decode.succeed Read

                    _ ->
                        Decode.fail ("Invalid RepositoryPermission type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : RepositoryPermission -> String
toString enum =
    case enum of
        Admin ->
            "ADMIN"

        Write ->
            "WRITE"

        Read ->
            "READ"
