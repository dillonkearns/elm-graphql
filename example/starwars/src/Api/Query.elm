module Api.Query exposing (..)

import Api.Object.Character
import Api.Object.Droid
import Api.Object.Human
import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query as Query
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)


type Type
    = Type


hero : List (TypeLocked Argument Api.Object.Character.Type) -> Object hero Api.Object.Character.Type -> Field.Query hero
hero optionalArgs object =
    Object.single "hero" optionalArgs object
        |> Query.rootQuery


human : List (TypeLocked Argument Api.Object.Human.Type) -> Object human Api.Object.Human.Type -> Field.Query human
human optionalArgs object =
    Object.single "human" optionalArgs object
        |> Query.rootQuery


droid : List (TypeLocked Argument Api.Object.Droid.Type) -> Object droid Api.Object.Droid.Type -> Field.Query droid
droid optionalArgs object =
    Object.single "droid" optionalArgs object
        |> Query.rootQuery
