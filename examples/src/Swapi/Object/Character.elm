module Swapi.Object.Character exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.Object


selection : (a -> constructor) -> SelectionSet (a -> constructor) Swapi.Object.Character
selection constructor =
    Object.object constructor


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Swapi.Enum.Episode.Episode) Swapi.Object.Character
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| The friends of the character, or an empty list if they have none.
-}
friends : SelectionSet character Swapi.Object.Character -> SelectionSet union Swapi.Object.Human -> SelectionSet union Swapi.Object.Droid -> FieldDecoder (List ( character, union )) Swapi.Object.Character
friends characterSelection humanSelection droidSelection =
    Object.polymorphicSelectionDecoder "friends" [] (Graphqelm.SelectionSet.singleton ( "Human", humanSelection ) |> Graphqelm.SelectionSet.add ( "Droid", droidSelection ) |> Graphqelm.SelectionSet.withBase characterSelection) (identity >> Decode.list)


{-| The ID of the character.
-}
id : FieldDecoder String Swapi.Object.Character
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the character.
-}
name : FieldDecoder String Swapi.Object.Character
name =
    Object.fieldDecoder "name" [] Decode.string
