module Api.Object.RepositoryInvitation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryInvitation
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.RepositoryInvitation
id =
    Object.fieldDecoder "id" [] Decode.string


invitee : Object invitee Api.Object.User -> FieldDecoder invitee Api.Object.RepositoryInvitation
invitee object =
    Object.single "invitee" [] object


inviter : Object inviter Api.Object.User -> FieldDecoder inviter Api.Object.RepositoryInvitation
inviter object =
    Object.single "inviter" [] object


repository : Object repository Api.Object.RepositoryInvitationRepository -> FieldDecoder repository Api.Object.RepositoryInvitation
repository object =
    Object.single "repository" [] object
