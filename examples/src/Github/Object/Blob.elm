module Github.Object.Blob exposing (..)

import Github.Interface
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


{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : FieldDecoder String Github.Object.Blob
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


{-| Byte size of Blob object
-}
byteSize : FieldDecoder Int Github.Object.Blob
byteSize =
    Object.fieldDecoder "byteSize" [] Decode.int


{-| The HTTP path for this Git object
-}
commitResourcePath : FieldDecoder String Github.Object.Blob
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


{-| The HTTP URL for this Git object
-}
commitUrl : FieldDecoder String Github.Object.Blob
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Github.Object.Blob
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Indicates whether the Blob is binary or text
-}
isBinary : FieldDecoder Bool Github.Object.Blob
isBinary =
    Object.fieldDecoder "isBinary" [] Decode.bool


{-| Indicates whether the contents is truncated
-}
isTruncated : FieldDecoder Bool Github.Object.Blob
isTruncated =
    Object.fieldDecoder "isTruncated" [] Decode.bool


{-| The Git object ID
-}
oid : FieldDecoder String Github.Object.Blob
oid =
    Object.fieldDecoder "oid" [] Decode.string


{-| The Repository the Git object belongs to
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Blob
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| UTF8 text data or null if the Blob is binary
-}
text : FieldDecoder (Maybe String) Github.Object.Blob
text =
    Object.fieldDecoder "text" [] (Decode.string |> Decode.maybe)
