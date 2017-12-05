module Api.Object.TreeEntry exposing (..)

import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Api.Object
import Json.Decode as Decode



build : (a -> constructor) -> Object (a -> constructor) Api.Object.TreeEntry
build constructor =
    Object.object constructor
mode : FieldDecoder Int Api.Object.TreeEntry
mode =
    Field.fieldDecoder "mode" [] (Decode.int)


name : FieldDecoder String Api.Object.TreeEntry
name =
    Field.fieldDecoder "name" [] (Decode.string)


object : Object object Api.Object.GitObject -> FieldDecoder object Api.Object.TreeEntry
object object =
    Object.single "object" [] object


oid : FieldDecoder String Api.Object.TreeEntry
oid =
    Field.fieldDecoder "oid" [] (Decode.string)


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.TreeEntry
repository object =
    Object.single "repository" [] object


type : FieldDecoder String Api.Object.TreeEntry
type =
    Field.fieldDecoder "type" [] (Decode.string)
