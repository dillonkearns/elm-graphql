module Api.Query exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    RootObject.object constructor


hero : ({ episode : Maybe Api.Enum.Episode.Episode } -> { episode : Maybe Api.Enum.Episode.Episode }) -> Object hero Api.Object.Character -> FieldDecoder hero RootQuery
hero fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Nothing }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Value.enum toString) ]
                |> List.filterMap identity
    in
    RootObject.single "hero" optionalArgs object


human : { id : String } -> Object human Api.Object.Human -> FieldDecoder human RootQuery
human requiredArgs object =
    RootObject.single "human" [ Argument.string "id" requiredArgs.id ] object


droid : { id : String } -> Object droid Api.Object.Droid -> FieldDecoder droid RootQuery
droid requiredArgs object =
    RootObject.single "droid" [ Argument.string "id" requiredArgs.id ] object
