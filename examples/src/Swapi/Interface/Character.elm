module Swapi.Interface.Character exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.Interface
import Swapi.Object
import Swapi.Union


{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Swapi.Interface.Character
commonSelection constructor =
    Object.object constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Swapi.Interface.Character) -> SelectionSet (a -> constructor) Swapi.Interface.Character
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onHuman : SelectionSet selection Swapi.Object.Human -> FragmentSelectionSet selection Swapi.Interface.Character
onHuman (SelectionSet fields decoder) =
    FragmentSelectionSet "Human" fields decoder


onDroid : SelectionSet selection Swapi.Object.Droid -> FragmentSelectionSet selection Swapi.Interface.Character
onDroid (SelectionSet fields decoder) =
    FragmentSelectionSet "Droid" fields decoder


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Swapi.Enum.Episode.Episode) Swapi.Interface.Character
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| The friends of the character, or an empty list if they have none.
-}
friends : SelectionSet selection Swapi.Interface.Character -> FieldDecoder (List selection) Swapi.Interface.Character
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


{-| The ID of the character.
-}
id : FieldDecoder String Swapi.Interface.Character
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the character.
-}
name : FieldDecoder String Swapi.Interface.Character
name =
    Object.fieldDecoder "name" [] Decode.string
