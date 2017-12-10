module Api.Query exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Document exposing (DocumentRoot)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


hero : ({ episode : Maybe Api.Enum.Episode.Episode } -> { episode : Maybe Api.Enum.Episode.Episode }) -> Object hero Api.Object.Character -> DocumentRoot hero
hero fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Nothing }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Value.enum toString) ]
                |> List.filterMap identity
    in
    Query.single "hero" optionalArgs object


human : { id : String } -> Object human Api.Object.Human -> DocumentRoot human
human requiredArgs object =
    Query.single "human" [ Argument.string "id" requiredArgs.id ] object


droid : { id : String } -> Object droid Api.Object.Droid -> DocumentRoot droid
droid requiredArgs object =
    Query.single "droid" [ Argument.string "id" requiredArgs.id ] object
