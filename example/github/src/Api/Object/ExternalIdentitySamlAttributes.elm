module Api.Object.ExternalIdentitySamlAttributes exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentitySamlAttributes
build constructor =
    Object.object constructor


nameId : FieldDecoder String Api.Object.ExternalIdentitySamlAttributes
nameId =
    Object.fieldDecoder "nameId" [] Decode.string
