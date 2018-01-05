module Github.Object.OrganizationIdentityProvider exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.OrganizationIdentityProvider
selection constructor =
    Object.object constructor


{-| The digest algorithm used to sign SAML requests for the Identity Provider.
-}
digestMethod : FieldDecoder (Maybe String) Github.Object.OrganizationIdentityProvider
digestMethod =
    Object.fieldDecoder "digestMethod" [] (Decode.string |> Decode.maybe)


{-| External Identities provisioned by this Identity Provider

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
externalIdentities : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.ExternalIdentityConnection -> FieldDecoder selection Github.Object.OrganizationIdentityProvider
externalIdentities fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "externalIdentities" optionalArgs object identity


id : FieldDecoder String Github.Object.OrganizationIdentityProvider
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The x509 certificate used by the Identity Provder to sign assertions and responses.
-}
idpCertificate : FieldDecoder (Maybe String) Github.Object.OrganizationIdentityProvider
idpCertificate =
    Object.fieldDecoder "idpCertificate" [] (Decode.string |> Decode.maybe)


{-| The Issuer Entity ID for the SAML Identity Provider
-}
issuer : FieldDecoder (Maybe String) Github.Object.OrganizationIdentityProvider
issuer =
    Object.fieldDecoder "issuer" [] (Decode.string |> Decode.maybe)


{-| Organization this Identity Provider belongs to
-}
organization : SelectionSet selection Github.Object.Organization -> FieldDecoder (Maybe selection) Github.Object.OrganizationIdentityProvider
organization object =
    Object.selectionFieldDecoder "organization" [] object (identity >> Decode.maybe)


{-| The signature algorithm used to sign SAML requests for the Identity Provider.
-}
signatureMethod : FieldDecoder (Maybe String) Github.Object.OrganizationIdentityProvider
signatureMethod =
    Object.fieldDecoder "signatureMethod" [] (Decode.string |> Decode.maybe)


{-| The URL endpoint for the Identity Provider's SAML SSO.
-}
ssoUrl : FieldDecoder (Maybe String) Github.Object.OrganizationIdentityProvider
ssoUrl =
    Object.fieldDecoder "ssoUrl" [] (Decode.string |> Decode.maybe)
