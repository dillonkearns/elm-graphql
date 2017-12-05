module Api.Enum.OrganizationInvitationRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


type OrganizationInvitationRole
    = DIRECT_MEMBER
    | ADMIN
    | BILLING_MANAGER
    | REINSTATE


decoder : Decoder OrganizationInvitationRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "DIRECT_MEMBER" ->
                        Decode.succeed DIRECT_MEMBER

                    "ADMIN" ->
                        Decode.succeed ADMIN

                    "BILLING_MANAGER" ->
                        Decode.succeed BILLING_MANAGER

                    "REINSTATE" ->
                        Decode.succeed REINSTATE

                    _ ->
                        Decode.fail ("Invalid OrganizationInvitationRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
