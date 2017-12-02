module Api.Object.Character exposing (..)

import Api.Enum.Episode
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


friends : Object friends Type -> TypeLocked (FieldDecoder (List friends)) Type
friends object =
    Object.listOf "friends" [] object
        |> TypeLocked


appearsIn : TypeLocked (FieldDecoder (List Api.Enum.Episode.Episode)) lockedTo
appearsIn =
    Field.fieldDecoder "appearsIn" (Api.Enum.Episode.decoder |> Decode.list)
