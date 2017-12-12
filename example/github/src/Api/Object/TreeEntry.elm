module Api.Object.TreeEntry exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TreeEntry
build constructor =
    Object.object constructor


mode : FieldDecoder Int Api.Object.TreeEntry
mode =
    Object.fieldDecoder "mode" [] Decode.int


name : FieldDecoder String Api.Object.TreeEntry
name =
    Object.fieldDecoder "name" [] Decode.string


object : Object object Api.Object.GitObject -> FieldDecoder object Api.Object.TreeEntry
object object =
    Object.single "object" [] object


oid : FieldDecoder String Api.Object.TreeEntry
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.TreeEntry
repository object =
    Object.single "repository" [] object


type_ : FieldDecoder String Api.Object.TreeEntry
type_ =
    Object.fieldDecoder "type" [] Decode.string
