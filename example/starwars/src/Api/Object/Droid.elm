module Api.Object.Droid exposing (..)

import Api.Enum.Episode
import Api.Object.Character
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor


id : FieldDecoder String Type
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Type
name =
    Field.fieldDecoder "name" [] Decode.string


friends : Object friends Api.Object.Character.Type -> FieldDecoder (List friends) Type
friends object =
    Object.listOf "friends" [] object


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Type
appearsIn =
    Field.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)


primaryFunction : FieldDecoder String Type
primaryFunction =
    Field.fieldDecoder "primaryFunction" [] Decode.string
