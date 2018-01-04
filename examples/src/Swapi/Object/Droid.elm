module Swapi.Object.Droid exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.Interface
import Swapi.Object
import Swapi.Union


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
friends : SelectionSet friends Swapi.Interface.Character -> FieldDecoder (List friends) Swapi.Object.Droid
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


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
