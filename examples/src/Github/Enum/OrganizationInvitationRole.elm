module Github.Enum.OrganizationInvitationRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible organization invitation roles.

  - DIRECT_MEMBER - The user is invited to be a direct member of the organization.
  - ADMIN - The user is invited to be an admin of the organization.
  - BILLING_MANAGER - The user is invited to be a billing manager of the organization.
  - REINSTATE - The user's previous role will be reinstated.

-}
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
