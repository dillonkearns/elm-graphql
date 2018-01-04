module Github.Enum.DefaultRepositoryPermissionField exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible default permissions for organization-owned repositories.

  - READ - Members have read access to org repos by default
  - WRITE - Members have read and write access to org repos by default
  - ADMIN - Members have read, write, and admin access to org repos by default

-}
type DefaultRepositoryPermissionField
    = READ
    | WRITE
    | ADMIN


decoder : Decoder DefaultRepositoryPermissionField
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "READ" ->
                        Decode.succeed READ

                    "WRITE" ->
                        Decode.succeed WRITE

                    "ADMIN" ->
                        Decode.succeed ADMIN

                    _ ->
                        Decode.fail ("Invalid DefaultRepositoryPermissionField type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : DefaultRepositoryPermissionField -> String
toString enum =
    case enum of
        READ ->
            "READ"

        WRITE ->
            "WRITE"

        ADMIN ->
            "ADMIN"
