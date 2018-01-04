module Normalize.Union.CharacterUnion exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode
import Normalize.Interface
import Normalize.Object
import Normalize.Union


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific Normalize.Union.CharacterUnion) -> SelectionSet constructor Normalize.Union.CharacterUnion
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor


onHuman : SelectionSet selection Normalize.Object.Human -> FragmentSelectionSet selection Normalize.Union.CharacterUnion
onHuman (SelectionSet fields decoder) =
    FragmentSelectionSet "Human" fields decoder


onDroid : SelectionSet selection Normalize.Object.Droid -> FragmentSelectionSet selection Normalize.Union.CharacterUnion
onDroid (SelectionSet fields decoder) =
    FragmentSelectionSet "Droid" fields decoder
