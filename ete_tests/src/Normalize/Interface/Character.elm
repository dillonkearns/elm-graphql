module Normalize.Interface.Character exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode
import Normalize.Enum.Episode_
import Normalize.Interface
import Normalize.Object
import Normalize.Union


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Normalize.Interface.Character
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Normalize.Interface.Character) -> SelectionSet (a -> constructor) Normalize.Interface.Character
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onHuman : SelectionSet selection Normalize.Object.Human -> FragmentSelectionSet selection Normalize.Interface.Character
onHuman (SelectionSet fields decoder) =
    FragmentSelectionSet "Human" fields decoder


onDroid : SelectionSet selection Normalize.Object.Droid -> FragmentSelectionSet selection Normalize.Interface.Character
onDroid (SelectionSet fields decoder) =
    FragmentSelectionSet "Droid" fields decoder


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Normalize.Enum.Episode_.Episode_) Normalize.Interface.Character
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Normalize.Enum.Episode_.decoder |> Decode.list)


{-| The friends of the character, or an empty list if they have none.
-}
friends : SelectionSet selection Normalize.Interface.Character -> FieldDecoder (List selection) Normalize.Interface.Character
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


{-| The ID of the character.
-}
id : FieldDecoder String Normalize.Interface.Character
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the character.
-}
name : FieldDecoder String Normalize.Interface.Character
name =
    Object.fieldDecoder "name" [] Decode.string
