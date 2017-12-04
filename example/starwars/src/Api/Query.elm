module Api.Query exposing (..)

import Api.Object
import Api.Object.Character
import Api.Object.Droid
import Api.Object.Human
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Json.Decode as Decode exposing (Decoder)


hero : Object hero Api.Object.Character -> Field.Query hero
hero object =
    Object.single "hero" [] object
        |> Query.rootQuery


human : { id : String } -> Object human Api.Object.Human -> Field.Query human
human requiredArgs object =
    Object.single "human" [ Argument.string "id" requiredArgs.id ] object
        |> Query.rootQuery


droid : { id : String } -> Object droid Api.Object.Droid -> Field.Query droid
droid requiredArgs object =
    Object.single "droid" [ Argument.string "id" requiredArgs.id ] object
        |> Query.rootQuery
