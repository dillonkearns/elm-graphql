module Api.Query exposing (..)

import Api.Object.Character
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
