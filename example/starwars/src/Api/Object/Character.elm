module Api.Object.Character exposing (..)

import Api.Enum.Episode
import Api.Object exposing (Character)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Character
build constructor =
    Object.object constructor


id : FieldDecoder String Character
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Character
name =
    Field.fieldDecoder "name" [] Decode.string


friends : Object friends Character -> FieldDecoder (List friends) Character
friends object =
    Object.listOf "friends" [] object


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Character
appearsIn =
    Field.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)
