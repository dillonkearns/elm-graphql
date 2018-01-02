module Swapi.Object.Droid exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.Object


selection : (a -> constructor) -> SelectionSet (a -> constructor) Swapi.Object.Droid
selection constructor =
    Object.object constructor


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Swapi.Enum.Episode.Episode) Swapi.Object.Droid
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| The friends of the droid, or an empty list if they have none.
-}
friends : SelectionSet character Swapi.Object.Character -> SelectionSet union Swapi.Object.Human -> SelectionSet union Swapi.Object.Droid -> FieldDecoder (List ( character, union )) Swapi.Object.Droid
friends characterSelection humanSelection droidSelection =
    Object.polymorphicSelectionDecoder "friends" [] (Graphqelm.SelectionSet.singleton ( "Human", humanSelection ) |> Graphqelm.SelectionSet.add ( "Droid", droidSelection ) |> Graphqelm.SelectionSet.withBase characterSelection) (identity >> Decode.list)


{-| The ID of the droid.
-}
id : FieldDecoder String Swapi.Object.Droid
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the droid.
-}
name : FieldDecoder String Swapi.Object.Droid
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The primary function of the droid.
-}
primaryFunction : FieldDecoder (Maybe String) Swapi.Object.Droid
primaryFunction =
    Object.fieldDecoder "primaryFunction" [] (Decode.string |> Decode.maybe)
