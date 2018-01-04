module Github.Interface.GitObject exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.GitObject
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.GitObject) -> SelectionSet (a -> constructor) Github.Interface.GitObject
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onBlob : SelectionSet selection Github.Object.Blob -> FragmentSelectionSet selection Github.Interface.GitObject
onBlob (SelectionSet fields decoder) =
    FragmentSelectionSet "Blob" fields decoder


onCommit : SelectionSet selection Github.Object.Commit -> FragmentSelectionSet selection Github.Interface.GitObject
onCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "Commit" fields decoder


onTag : SelectionSet selection Github.Object.Tag -> FragmentSelectionSet selection Github.Interface.GitObject
onTag (SelectionSet fields decoder) =
    FragmentSelectionSet "Tag" fields decoder


onTree : SelectionSet selection Github.Object.Tree -> FragmentSelectionSet selection Github.Interface.GitObject
onTree (SelectionSet fields decoder) =
    FragmentSelectionSet "Tree" fields decoder


{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : FieldDecoder String Github.Interface.GitObject
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


{-| The HTTP path for this Git object
-}
commitResourcePath : FieldDecoder String Github.Interface.GitObject
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


{-| The HTTP URL for this Git object
-}
commitUrl : FieldDecoder String Github.Interface.GitObject
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


id : FieldDecoder String Github.Interface.GitObject
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The Git object ID
-}
oid : FieldDecoder String Github.Interface.GitObject
oid =
    Object.fieldDecoder "oid" [] Decode.string


{-| The Repository the Git object belongs to
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Interface.GitObject
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
