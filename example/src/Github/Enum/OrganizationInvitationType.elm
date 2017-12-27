module Github.Enum.OrganizationInvitationType exposing (..)

import Json.Decode as Decode exposing (Decoder)


type OrganizationInvitationType
    = USER
    | EMAIL


decoder : Decoder OrganizationInvitationType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "USER" ->
                        Decode.succeed USER

                    "EMAIL" ->
                        Decode.succeed EMAIL

                    _ ->
                        Decode.fail ("Invalid OrganizationInvitationType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
