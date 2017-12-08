module Api.Object.Character exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Character
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Character
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Character
name =
    Field.fieldDecoder "name" [] Decode.string


friends : Object friends Api.Object.Character -> FieldDecoder (List friends) Api.Object.Character
friends object =
    Object.listOf "friends" [] object


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Api.Object.Character
appearsIn =
    Field.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)
