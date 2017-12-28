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


appearsIn : FieldDecoder (List Swapi.Enum.Episode.Episode) Swapi.Object.Droid
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


friends : SelectionSet friends Swapi.Object.Character -> FieldDecoder (List friends) Swapi.Object.Droid
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


id : FieldDecoder String Swapi.Object.Droid
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Swapi.Object.Droid
name =
    Object.fieldDecoder "name" [] Decode.string


primaryFunction : FieldDecoder String Swapi.Object.Droid
primaryFunction =
    Object.fieldDecoder "primaryFunction" [] Decode.string
