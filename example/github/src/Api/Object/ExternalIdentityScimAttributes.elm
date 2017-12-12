module Api.Object.ExternalIdentityScimAttributes exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentityScimAttributes
build constructor =
    Object.object constructor


username : FieldDecoder String Api.Object.ExternalIdentityScimAttributes
username =
    Object.fieldDecoder "username" [] Decode.string
