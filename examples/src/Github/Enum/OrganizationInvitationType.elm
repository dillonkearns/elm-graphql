module Github.Enum.OrganizationInvitationType exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible organization invitation types.

  - USER - The invitation was to an existing user.
  - EMAIL - The invitation was to an email address.

-}
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


toString : OrganizationInvitationType -> String
toString enum =
    case enum of
        USER ->
            "USER"

        EMAIL ->
            "EMAIL"
