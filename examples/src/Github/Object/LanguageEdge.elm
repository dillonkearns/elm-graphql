module Github.Object.LanguageEdge exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.LanguageEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.LanguageEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Github.Object.Language -> FieldDecoder node Github.Object.LanguageEdge
node object =
    Object.selectionFieldDecoder "node" [] object identity


{-| The number of bytes of code written in the language.
-}
size : FieldDecoder Int Github.Object.LanguageEdge
size =
    Object.fieldDecoder "size" [] Decode.int
