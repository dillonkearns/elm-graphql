module Github.Enum.OrganizationInvitationType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible organization invitation types.

  - User - The invitation was to an existing user.
  - Email - The invitation was to an email address.

-}
type OrganizationInvitationType
    = User
    | Email


decoder : Decoder OrganizationInvitationType
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "USER" ->
                        Decode.succeed User

                    "EMAIL" ->
                        Decode.succeed Email

                    _ ->
                        Decode.fail ("Invalid OrganizationInvitationType type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


toString : OrganizationInvitationType -> String
toString enum =
    case enum of
        User ->
            "USER"

        Email ->
            "EMAIL"
