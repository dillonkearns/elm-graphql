module Api.Object.LanguageEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LanguageEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.LanguageEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Language -> FieldDecoder node Api.Object.LanguageEdge
node object =
    Object.single "node" [] object


size : FieldDecoder Int Api.Object.LanguageEdge
size =
    Object.fieldDecoder "size" [] Decode.int
