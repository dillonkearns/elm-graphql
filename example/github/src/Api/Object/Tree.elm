module Api.Object.Tree exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Tree
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Tree
abbreviatedOid =
    Field.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.Tree
commitResourcePath =
    Field.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Tree
commitUrl =
    Field.fieldDecoder "commitUrl" [] Decode.string


entries : Object entries Api.Object.TreeEntry -> FieldDecoder (List entries) Api.Object.Tree
entries object =
    Object.listOf "entries" [] object


id : FieldDecoder String Api.Object.Tree
id =
    Field.fieldDecoder "id" [] Decode.string


oid : FieldDecoder String Api.Object.Tree
oid =
    Field.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Tree
repository object =
    Object.single "repository" [] object
