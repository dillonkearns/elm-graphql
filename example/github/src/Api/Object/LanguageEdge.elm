module Api.Object.LanguageEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LanguageEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.LanguageEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.Language -> FieldDecoder node Api.Object.LanguageEdge
node object =
    Object.single "node" [] object


size : FieldDecoder Int Api.Object.LanguageEdge
size =
    Field.fieldDecoder "size" [] Decode.int
