module Api.Query exposing (..)

import Api.Enum.Episode
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor


droid : { id : String } -> SelectionSet droid Api.Object.Droid -> FieldDecoder droid RootQuery
droid requiredArgs object =
    Object.single "droid" [ Argument.string "id" requiredArgs.id ] object


hero : ({ episode : OptionalArgument Api.Enum.Episode.Episode } -> { episode : OptionalArgument Api.Enum.Episode.Episode }) -> SelectionSet hero Api.Object.Character -> FieldDecoder hero RootQuery
hero fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Absent }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.single "hero" optionalArgs object


human : { id : String } -> SelectionSet human Api.Object.Human -> FieldDecoder human RootQuery
human requiredArgs object =
    Object.single "human" [ Argument.string "id" requiredArgs.id ] object
