module Github.Object.GitObject exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.GitObject
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Object.GitObject) -> SelectionSet (a -> constructor) Github.Object.GitObject
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onBlob : SelectionSet selection Github.Object.Blob -> FragmentSelectionSet selection Github.Object.GitObject
onBlob (SelectionSet fields decoder) =
    FragmentSelectionSet "Blob" fields decoder


onCommit : SelectionSet selection Github.Object.Commit -> FragmentSelectionSet selection Github.Object.GitObject
onCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "Commit" fields decoder


onTag : SelectionSet selection Github.Object.Tag -> FragmentSelectionSet selection Github.Object.GitObject
onTag (SelectionSet fields decoder) =
    FragmentSelectionSet "Tag" fields decoder


onTree : SelectionSet selection Github.Object.Tree -> FragmentSelectionSet selection Github.Object.GitObject
onTree (SelectionSet fields decoder) =
    FragmentSelectionSet "Tree" fields decoder


{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : FieldDecoder String Github.Object.GitObject
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


{-| The HTTP path for this Git object
-}
commitResourcePath : FieldDecoder String Github.Object.GitObject
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


{-| The HTTP URL for this Git object
-}
commitUrl : FieldDecoder String Github.Object.GitObject
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Github.Object.GitObject
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The Git object ID
-}
oid : FieldDecoder String Github.Object.GitObject
oid =
    Object.fieldDecoder "oid" [] Decode.string


{-| The Repository the Git object belongs to
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.GitObject
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
