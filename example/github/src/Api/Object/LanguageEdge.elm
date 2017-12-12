module Api.Object.LanguageEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


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
