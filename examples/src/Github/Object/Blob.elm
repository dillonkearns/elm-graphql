module Github.Object.Blob exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Blob
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Github.Object.Blob
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


byteSize : FieldDecoder Int Github.Object.Blob
byteSize =
    Object.fieldDecoder "byteSize" [] Decode.int


commitResourcePath : FieldDecoder String Github.Object.Blob
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Github.Object.Blob
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Github.Object.Blob
id =
    Object.fieldDecoder "id" [] Decode.string


isBinary : FieldDecoder Bool Github.Object.Blob
isBinary =
    Object.fieldDecoder "isBinary" [] Decode.bool


isTruncated : FieldDecoder Bool Github.Object.Blob
isTruncated =
    Object.fieldDecoder "isTruncated" [] Decode.bool


oid : FieldDecoder String Github.Object.Blob
oid =
    Object.fieldDecoder "oid" [] Decode.string


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Blob
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


text : FieldDecoder (Maybe String) Github.Object.Blob
text =
    Object.fieldDecoder "text" [] (Decode.string |> Decode.maybe)
