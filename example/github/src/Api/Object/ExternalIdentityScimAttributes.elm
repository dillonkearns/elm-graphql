module Api.Object.ExternalIdentityScimAttributes exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentityScimAttributes
build constructor =
    Object.object constructor


username : FieldDecoder String Api.Object.ExternalIdentityScimAttributes
username =
    Object.fieldDecoder "username" [] Decode.string
