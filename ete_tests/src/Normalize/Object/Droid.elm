module Normalize.Object.Droid exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Normalize.Enum.Episode_
import Normalize.Interface
import Normalize.Object
import Normalize.Union


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Normalize.Object.Droid
selection constructor =
    Object.selection constructor


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Normalize.Enum.Episode_.Episode_) Normalize.Object.Droid
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Normalize.Enum.Episode_.decoder |> Decode.list)


{-| The friends of the droid, or an empty list if they have none.
-}
friends : SelectionSet selection Normalize.Interface.Character -> FieldDecoder (List selection) Normalize.Object.Droid
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


{-| The ID of the droid.
-}
id : FieldDecoder String Normalize.Object.Droid
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the droid.
-}
name : FieldDecoder String Normalize.Object.Droid
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The primary function of the droid.
-}
primaryFunction : FieldDecoder (Maybe String) Normalize.Object.Droid
primaryFunction =
    Object.fieldDecoder "primaryFunction" [] (Decode.string |> Decode.maybe)
