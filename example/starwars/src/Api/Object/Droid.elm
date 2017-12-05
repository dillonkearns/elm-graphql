module Api.Object.Droid exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Droid
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Droid
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Droid
name =
    Field.fieldDecoder "name" [] Decode.string


friends : Object friends Api.Object.Character -> FieldDecoder (List friends) Api.Object.Droid
friends object =
    Object.listOf "friends" [] object


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Api.Object.Droid
appearsIn =
    Field.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)


primaryFunction : FieldDecoder String Api.Object.Droid
primaryFunction =
    Field.fieldDecoder "primaryFunction" [] Decode.string
