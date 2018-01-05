module Github.Enum.OrganizationInvitationRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible organization invitation roles.

  - DirectMember - The user is invited to be a direct member of the organization.
  - Admin - The user is invited to be an admin of the organization.
  - BillingManager - The user is invited to be a billing manager of the organization.
  - Reinstate - The user's previous role will be reinstated.

-}
type OrganizationInvitationRole
    = DirectMember
    | Admin
    | BillingManager
    | Reinstate


decoder : Decoder OrganizationInvitationRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "DIRECT_MEMBER" ->
                        Decode.succeed DirectMember

                    "ADMIN" ->
                        Decode.succeed Admin

                    "BILLING_MANAGER" ->
                        Decode.succeed BillingManager

                    "REINSTATE" ->
                        Decode.succeed Reinstate

                    _ ->
                        Decode.fail ("Invalid OrganizationInvitationRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : OrganizationInvitationRole -> String
toString enum =
    case enum of
        DirectMember ->
            "DIRECT_MEMBER"

        Admin ->
            "ADMIN"

        BillingManager ->
            "BILLING_MANAGER"

        Reinstate ->
            "REINSTATE"
