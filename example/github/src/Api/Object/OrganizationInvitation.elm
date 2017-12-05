module Api.Object.OrganizationInvitation exposing (..)

import Api.Enum.OrganizationInvitationRole
import Api.Enum.OrganizationInvitationType
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationInvitation
build constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.OrganizationInvitation
email =
    Field.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Api.Object.OrganizationInvitation
id =
    Field.fieldDecoder "id" [] Decode.string


invitationType : FieldDecoder Api.Enum.OrganizationInvitationType.OrganizationInvitationType Api.Object.OrganizationInvitation
invitationType =
    Field.fieldDecoder "invitationType" [] Api.Enum.OrganizationInvitationType.decoder


invitee : Object invitee Api.Object.User -> FieldDecoder invitee Api.Object.OrganizationInvitation
invitee object =
    Object.single "invitee" [] object


inviter : Object inviter Api.Object.User -> FieldDecoder inviter Api.Object.OrganizationInvitation
inviter object =
    Object.single "inviter" [] object


role : FieldDecoder Api.Enum.OrganizationInvitationRole.OrganizationInvitationRole Api.Object.OrganizationInvitation
role =
    Field.fieldDecoder "role" [] Api.Enum.OrganizationInvitationRole.decoder
