module Github.Object.Tree exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Tree
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Github.Object.Tree
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


commitResourcePath : FieldDecoder String Github.Object.Tree
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Github.Object.Tree
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


entries : SelectionSet entries Github.Object.TreeEntry -> FieldDecoder (List entries) Github.Object.Tree
entries object =
    Object.listOf "entries" [] object


id : FieldDecoder String Github.Object.Tree
id =
    Object.fieldDecoder "id" [] Decode.string


oid : FieldDecoder String Github.Object.Tree
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Tree
repository object =
    Object.single "repository" [] object
