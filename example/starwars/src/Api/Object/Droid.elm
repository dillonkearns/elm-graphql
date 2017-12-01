module Api.Object.Droid exposing (..)

import Api.Enum.Episode
import Api.Object.Character
import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode


type Type
    = Type


build : (a -> constructor) -> Object (a -> constructor) Type
build constructor =
    Object.object constructor


id : TypeLocked (FieldDecoder String) Type
id =
    Field.fieldDecoder "id" Decode.string


name : TypeLocked (FieldDecoder String) Type
name =
    Field.fieldDecoder "name" Decode.string


friends : List (TypeLocked Argument Api.Object.Character.Type) -> Object friends Api.Object.Character.Type -> TypeLocked (FieldDecoder (List friends)) lockedTo
friends optionalArgs object =
    Object.listOf "friends" optionalArgs object
        |> TypeLocked


appearsIn : TypeLocked (FieldDecoder (List Api.Enum.Episode.Episode)) lockedTo
appearsIn =
    Field.fieldDecoder "appearsIn" (Api.Enum.Episode.decoder |> Decode.list)


primaryFunction : TypeLocked (FieldDecoder String) Type
primaryFunction =
    Field.fieldDecoder "primaryFunction" Decode.string
