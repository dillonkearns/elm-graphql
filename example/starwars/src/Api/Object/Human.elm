module Api.Object.Human exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Human
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Human
id =
    Field.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.Human
name =
    Field.fieldDecoder "name" [] Decode.string


friends : Object friends Api.Object.Character -> FieldDecoder (List friends) Api.Object.Human
friends object =
    Object.listOf "friends" [] object


appearsIn : FieldDecoder (List Api.Enum.Episode.Episode) Api.Object.Human
appearsIn =
    Field.fieldDecoder "appearsIn" [] (Api.Enum.Episode.decoder |> Decode.list)


homePlanet : FieldDecoder String Api.Object.Human
homePlanet =
    Field.fieldDecoder "homePlanet" [] Decode.string
