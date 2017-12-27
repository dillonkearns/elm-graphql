module Github.Object.OrganizationInvitation exposing (..)

import Github.Enum.OrganizationInvitationRole
import Github.Enum.OrganizationInvitationType
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.OrganizationInvitation
selection constructor =
    Object.object constructor


email : FieldDecoder String Github.Object.OrganizationInvitation
email =
    Object.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Github.Object.OrganizationInvitation
id =
    Object.fieldDecoder "id" [] Decode.string


invitationType : FieldDecoder Github.Enum.OrganizationInvitationType.OrganizationInvitationType Github.Object.OrganizationInvitation
invitationType =
    Object.fieldDecoder "invitationType" [] Github.Enum.OrganizationInvitationType.decoder


invitee : SelectionSet invitee Github.Object.User -> FieldDecoder invitee Github.Object.OrganizationInvitation
invitee object =
    Object.single "invitee" [] object


inviter : SelectionSet inviter Github.Object.User -> FieldDecoder inviter Github.Object.OrganizationInvitation
inviter object =
    Object.single "inviter" [] object


role : FieldDecoder Github.Enum.OrganizationInvitationRole.OrganizationInvitationRole Github.Object.OrganizationInvitation
role =
    Object.fieldDecoder "role" [] Github.Enum.OrganizationInvitationRole.decoder
