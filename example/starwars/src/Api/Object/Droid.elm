module Api.Object.Droid exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Droid
selection constructor =
    Object.object constructor


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Api.Object.Droid
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)


friends : SelectionSet friends Api.Object.Character -> FieldDecoder (List friends) Api.Object.Droid
friends object =
    Object.listOf "friends" [] object


id : FieldDecoder String Api.Object.Droid
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Droid
name =
    Object.fieldDecoder "name" [] Decode.string


primaryFunction : FieldDecoder String Api.Object.Droid
primaryFunction =
    Object.fieldDecoder "primaryFunction" [] Decode.string
