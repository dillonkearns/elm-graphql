module Api.Object.OrganizationIdentityProvider exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.OrganizationIdentityProvider
build constructor =
    Object.object constructor


digestMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
digestMethod =
    Object.fieldDecoder "digestMethod" [] Decode.string


externalIdentities : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object externalIdentities Api.Object.ExternalIdentityConnection -> FieldDecoder externalIdentities Api.Object.OrganizationIdentityProvider
externalIdentities fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Object.single "externalIdentities" optionalArgs object


id : FieldDecoder String Api.Object.OrganizationIdentityProvider
id =
    Object.fieldDecoder "id" [] Decode.string


idpCertificate : FieldDecoder String Api.Object.OrganizationIdentityProvider
idpCertificate =
    Object.fieldDecoder "idpCertificate" [] Decode.string


issuer : FieldDecoder String Api.Object.OrganizationIdentityProvider
issuer =
    Object.fieldDecoder "issuer" [] Decode.string


organization : Object organization Api.Object.Organization -> FieldDecoder organization Api.Object.OrganizationIdentityProvider
organization object =
    Object.single "organization" [] object


signatureMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
signatureMethod =
    Object.fieldDecoder "signatureMethod" [] Decode.string


ssoUrl : FieldDecoder String Api.Object.OrganizationIdentityProvider
ssoUrl =
    Object.fieldDecoder "ssoUrl" [] Decode.string
