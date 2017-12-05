module Api.Object.OrganizationIdentityProvider exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationIdentityProvider
build constructor =
    Object.object constructor


digestMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
digestMethod =
    Field.fieldDecoder "digestMethod" [] Decode.string


externalIdentities : Object externalIdentities Api.Object.ExternalIdentityConnection -> FieldDecoder externalIdentities Api.Object.OrganizationIdentityProvider
externalIdentities object =
    Object.single "externalIdentities" [] object


id : FieldDecoder String Api.Object.OrganizationIdentityProvider
id =
    Field.fieldDecoder "id" [] Decode.string


idpCertificate : FieldDecoder String Api.Object.OrganizationIdentityProvider
idpCertificate =
    Field.fieldDecoder "idpCertificate" [] Decode.string


issuer : FieldDecoder String Api.Object.OrganizationIdentityProvider
issuer =
    Field.fieldDecoder "issuer" [] Decode.string


organization : Object organization Api.Object.Organization -> FieldDecoder organization Api.Object.OrganizationIdentityProvider
organization object =
    Object.single "organization" [] object


signatureMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
signatureMethod =
    Field.fieldDecoder "signatureMethod" [] Decode.string


ssoUrl : FieldDecoder String Api.Object.OrganizationIdentityProvider
ssoUrl =
    Field.fieldDecoder "ssoUrl" [] Decode.string
