module Swapi.Query exposing (..)

import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import Swapi.Enum.Episode
import Swapi.Object


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor


droid : { id : String } -> SelectionSet droid Swapi.Object.Droid -> FieldDecoder (Maybe droid) RootQuery
droid requiredArgs object =
    Object.selectionFieldDecoder "droid" [ Argument.required "id" (requiredArgs.id |> Encode.string) ] object (identity >> Decode.maybe)


hero : ({ episode : OptionalArgument Swapi.Enum.Episode.Episode } -> { episode : OptionalArgument Swapi.Enum.Episode.Episode }) -> SelectionSet hero Swapi.Object.Character -> FieldDecoder (Maybe hero) RootQuery
hero fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Absent }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "hero" optionalArgs object (identity >> Decode.maybe)


human : { id : String } -> SelectionSet human Swapi.Object.Human -> FieldDecoder (Maybe human) RootQuery
human requiredArgs object =
    Object.selectionFieldDecoder "human" [ Argument.required "id" (requiredArgs.id |> Encode.string) ] object (identity >> Decode.maybe)
