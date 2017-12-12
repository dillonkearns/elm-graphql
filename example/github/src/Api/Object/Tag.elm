module Api.Object.Tag exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Tag
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Tag
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.Tag
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Tag
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Api.Object.Tag
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Api.Object.Tag
message =
    Object.fieldDecoder "message" [] Decode.string


name : FieldDecoder String Api.Object.Tag
name =
    Object.fieldDecoder "name" [] Decode.string


oid : FieldDecoder String Api.Object.Tag
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Tag
repository object =
    Object.single "repository" [] object


tagger : Object tagger Api.Object.GitActor -> FieldDecoder tagger Api.Object.Tag
tagger object =
    Object.single "tagger" [] object


target : Object target Api.Object.GitObject -> FieldDecoder target Api.Object.Tag
target object =
    Object.single "target" [] object
