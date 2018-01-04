module Github.Object.ExternalIdentitySamlAttributes exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ExternalIdentitySamlAttributes
selection constructor =
    Object.object constructor


{-| The NameID of the SAML identity
-}
nameId : FieldDecoder (Maybe String) Github.Object.ExternalIdentitySamlAttributes
nameId =
    Object.fieldDecoder "nameId" [] (Decode.string |> Decode.maybe)
