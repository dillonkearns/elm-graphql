module Api.Object.GitObject exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.GitObject
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.GitObject
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Api.Object.GitObject
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.GitObject
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Api.Object.GitObject
id =
    Object.fieldDecoder "id" [] Decode.string


oid : FieldDecoder String Api.Object.GitObject
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.GitObject
repository object =
    Object.single "repository" [] object
