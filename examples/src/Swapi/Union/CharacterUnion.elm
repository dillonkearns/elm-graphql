module Swapi.Union.CharacterUnion exposing (..)

import Graphqelm.Builder.Object as Object
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Swapi.Object
import Swapi.Union


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific Swapi.Union.CharacterUnion) -> SelectionSet constructor Swapi.Union.CharacterUnion
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor


onHuman : SelectionSet selection Swapi.Object.Human -> FragmentSelectionSet selection Swapi.Union.CharacterUnion
onHuman (SelectionSet fields decoder) =
    FragmentSelectionSet "Human" fields decoder


onDroid : SelectionSet selection Swapi.Object.Droid -> FragmentSelectionSet selection Swapi.Union.CharacterUnion
onDroid (SelectionSet fields decoder) =
    FragmentSelectionSet "Droid" fields decoder
