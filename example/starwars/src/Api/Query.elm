module Api.Query exposing (..)

import Api.Object.Character
import Api.Object.Droid
import Api.Object.Human
import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query as Query
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))


type Type
    = Type


hero : List (TypeLocked Argument Api.Object.Character.Type) -> Object hero Api.Object.Character.Type -> Field.Query hero
hero optionalArgs object =
    Object.single "hero" optionalArgs object
        |> Query.rootQuery


human : { id : String } -> Object human Api.Object.Human.Type -> Field.Query human
human requiredArgs object =
    Object.single "human" [ Argument.string "id" requiredArgs.id ] object
        |> Query.rootQuery


droid : { id : String } -> Object droid Api.Object.Droid.Type -> Field.Query droid
droid requiredArgs object =
    Object.single "droid" [ Argument.string "id" requiredArgs.id ] object
        |> Query.rootQuery
