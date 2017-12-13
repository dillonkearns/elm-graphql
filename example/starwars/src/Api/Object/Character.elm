module Api.Object.Character exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Character
build constructor =
    Object.object constructor


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Api.Object.Character
appearsIn =
    Object.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)


friends : Object friends Api.Object.Character -> FieldDecoder (List friends) Api.Object.Character
friends object =
    Object.listOf "friends" [] object


id : FieldDecoder String Api.Object.Character
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Character
name =
    Object.fieldDecoder "name" [] Decode.string
