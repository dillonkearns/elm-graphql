module Github.Object.Tag exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Tag
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Github.Object.Tag
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Github.Object.Tag
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Github.Object.Tag
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Github.Object.Tag
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Github.Object.Tag
message =
    Object.fieldDecoder "message" [] Decode.string


name : FieldDecoder String Github.Object.Tag
name =
    Object.fieldDecoder "name" [] Decode.string


oid : FieldDecoder String Github.Object.Tag
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Tag
repository object =
    Object.single "repository" [] object


tagger : SelectionSet tagger Github.Object.GitActor -> FieldDecoder tagger Github.Object.Tag
tagger object =
    Object.single "tagger" [] object


target : SelectionSet target Github.Object.GitObject -> FieldDecoder target Github.Object.Tag
target object =
    Object.single "target" [] object
