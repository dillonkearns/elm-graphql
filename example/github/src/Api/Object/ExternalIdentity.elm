module Api.Object.ExternalIdentity exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ExternalIdentity
selection constructor =
    Object.object constructor


guid : FieldDecoder String Api.Object.ExternalIdentity
guid =
    Object.fieldDecoder "guid" [] Decode.string


id : FieldDecoder String Api.Object.ExternalIdentity
id =
    Object.fieldDecoder "id" [] Decode.string


organizationInvitation : SelectionSet organizationInvitation Api.Object.OrganizationInvitation -> FieldDecoder organizationInvitation Api.Object.ExternalIdentity
organizationInvitation object =
    Object.single "organizationInvitation" [] object


samlIdentity : SelectionSet samlIdentity Api.Object.ExternalIdentitySamlAttributes -> FieldDecoder samlIdentity Api.Object.ExternalIdentity
samlIdentity object =
    Object.single "samlIdentity" [] object


scimIdentity : SelectionSet scimIdentity Api.Object.ExternalIdentityScimAttributes -> FieldDecoder scimIdentity Api.Object.ExternalIdentity
scimIdentity object =
    Object.single "scimIdentity" [] object


user : SelectionSet user Api.Object.User -> FieldDecoder user Api.Object.ExternalIdentity
user object =
    Object.single "user" [] object
