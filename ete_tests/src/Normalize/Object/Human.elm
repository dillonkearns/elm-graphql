module Normalize.Object.Human exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Normalize.Object.Human
selection constructor =
    Object.object constructor


{-| Which movies they appear in.
-}
appearsIn : FieldDecoder (List Normalize.Enum.Episode_.Episode_) Normalize.Object.Human
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Normalize.Enum.Episode_.decoder |> Decode.list)


{-| The friends of the human, or an empty list if they have none.
-}
friends : SelectionSet friends Normalize.Interface.Character -> FieldDecoder (List friends) Normalize.Object.Human
friends object =
    Object.selectionFieldDecoder "friends" [] object (identity >> Decode.list)


{-| The home planet of the human, or null if unknown.
-}
homePlanet : FieldDecoder (Maybe String) Normalize.Object.Human
homePlanet =
    Object.fieldDecoder "homePlanet" [] (Decode.string |> Decode.maybe)


{-| The ID of the human.
-}
id : FieldDecoder String Normalize.Object.Human
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The name of the human.
-}
name : FieldDecoder String Normalize.Object.Human
name =
    Object.fieldDecoder "name" [] Decode.string
