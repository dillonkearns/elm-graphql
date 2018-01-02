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


{-|

  - id - ID of the droid.

-}
droid : { id : String } -> SelectionSet droid Swapi.Object.Droid -> FieldDecoder (Maybe droid) RootQuery
droid requiredArgs object =
    Object.selectionFieldDecoder "droid" [ Argument.required "id" requiredArgs.id Encode.string ] object (identity >> Decode.maybe)


{-|

  - episode - If omitted, returns the hero of the whole saga. If provided, returns the hero of that particular episode.

-}
hero : ({ episode : OptionalArgument Swapi.Enum.Episode.Episode } -> { episode : OptionalArgument Swapi.Enum.Episode.Episode }) -> SelectionSet character Swapi.Object.Character -> SelectionSet union Swapi.Object.Human -> SelectionSet union Swapi.Object.Droid -> FieldDecoder (Maybe ( character, union )) RootQuery
hero fillInOptionals characterSelection humanSelection droidSelection =
    let
        filledInOptionals =
            fillInOptionals { episode = Absent }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.polymorphicSelectionDecoder "hero" optionalArgs (Graphqelm.SelectionSet.singleton ( "Human", humanSelection ) |> Graphqelm.SelectionSet.add ( "Droid", droidSelection ) |> Graphqelm.SelectionSet.withBase characterSelection) (identity >> Decode.maybe)


{-|

  - id - ID of the human.

-}
human : { id : String } -> SelectionSet human Swapi.Object.Human -> FieldDecoder (Maybe human) RootQuery
human requiredArgs object =
    Object.selectionFieldDecoder "human" [ Argument.required "id" requiredArgs.id Encode.string ] object (identity >> Decode.maybe)
