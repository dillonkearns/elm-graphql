module Api.Object.GitObject exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GitObject
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.GitObject
abbreviatedOid =
    Field.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.GitObject
commitResourcePath =
    Field.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.GitObject
commitUrl =
    Field.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Api.Object.GitObject
id =
    Field.fieldDecoder "id" [] Decode.string


oid : FieldDecoder String Api.Object.GitObject
oid =
    Field.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.GitObject
repository object =
    Object.single "repository" [] object
