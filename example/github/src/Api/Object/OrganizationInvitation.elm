module Api.Object.OrganizationInvitation exposing (..)

import Api.Enum.OrganizationInvitationRole
import Api.Enum.OrganizationInvitationType
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationInvitation
build constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.OrganizationInvitation
email =
    Object.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Api.Object.OrganizationInvitation
id =
    Object.fieldDecoder "id" [] Decode.string


invitationType : FieldDecoder Api.Enum.OrganizationInvitationType.OrganizationInvitationType Api.Object.OrganizationInvitation
invitationType =
    Object.fieldDecoder "invitationType" [] Api.Enum.OrganizationInvitationType.decoder


invitee : Object invitee Api.Object.User -> FieldDecoder invitee Api.Object.OrganizationInvitation
invitee object =
    Object.single "invitee" [] object


inviter : Object inviter Api.Object.User -> FieldDecoder inviter Api.Object.OrganizationInvitation
inviter object =
    Object.single "inviter" [] object


role : FieldDecoder Api.Enum.OrganizationInvitationRole.OrganizationInvitationRole Api.Object.OrganizationInvitation
role =
    Object.fieldDecoder "role" [] Api.Enum.OrganizationInvitationRole.decoder
