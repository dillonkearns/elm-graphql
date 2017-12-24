module Api.Object.OrganizationIdentityProvider exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.OrganizationIdentityProvider
selection constructor =
    Object.object constructor


digestMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
digestMethod =
    Object.fieldDecoder "digestMethod" [] Decode.string


externalIdentities : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> SelectionSet externalIdentities Api.Object.ExternalIdentityConnection -> FieldDecoder externalIdentities Api.Object.OrganizationIdentityProvider
externalIdentities fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
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


organization : SelectionSet organization Api.Object.Organization -> FieldDecoder organization Api.Object.OrganizationIdentityProvider
organization object =
    Object.single "organization" [] object


signatureMethod : FieldDecoder String Api.Object.OrganizationIdentityProvider
signatureMethod =
    Object.fieldDecoder "signatureMethod" [] Decode.string


ssoUrl : FieldDecoder String Api.Object.OrganizationIdentityProvider
ssoUrl =
    Object.fieldDecoder "ssoUrl" [] Decode.string
