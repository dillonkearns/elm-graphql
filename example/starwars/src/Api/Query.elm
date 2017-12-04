module Api.Query exposing (..)

import Api.Enum.Episode
import Api.Object.Character
import Api.Object.Droid
import Api.Object.Human
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query


type Type
    = Type


hero : ({ episode : Maybe Api.Enum.Episode.Episode } -> { episode : Maybe Api.Enum.Episode.Episode }) -> Object hero Api.Object.Character.Type -> Field.Query hero
hero fillInArgs object =
    let
        optionalArgsThing =
            fillInArgs { episode = Nothing }

        optionalArgs =
            [ Maybe.map (\value -> Argument.enum "episode" (toString value)) optionalArgsThing.episode ]
                |> List.filterMap identity
    in
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
