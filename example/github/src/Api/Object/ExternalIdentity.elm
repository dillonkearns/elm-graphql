module Api.Object.ExternalIdentity exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentity
build constructor =
    Object.object constructor


guid : FieldDecoder String Api.Object.ExternalIdentity
guid =
    Object.fieldDecoder "guid" [] Decode.string


id : FieldDecoder String Api.Object.ExternalIdentity
id =
    Object.fieldDecoder "id" [] Decode.string


organizationInvitation : Object organizationInvitation Api.Object.OrganizationInvitation -> FieldDecoder organizationInvitation Api.Object.ExternalIdentity
organizationInvitation object =
    Object.single "organizationInvitation" [] object


samlIdentity : Object samlIdentity Api.Object.ExternalIdentitySamlAttributes -> FieldDecoder samlIdentity Api.Object.ExternalIdentity
samlIdentity object =
    Object.single "samlIdentity" [] object


scimIdentity : Object scimIdentity Api.Object.ExternalIdentityScimAttributes -> FieldDecoder scimIdentity Api.Object.ExternalIdentity
scimIdentity object =
    Object.single "scimIdentity" [] object


user : Object user Api.Object.User -> FieldDecoder user Api.Object.ExternalIdentity
user object =
    Object.single "user" [] object
