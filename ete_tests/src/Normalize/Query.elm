module Normalize.Query exposing (..)

import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import Normalize.Enum.Episode_
import Normalize.Interface
import Normalize.Object
import Normalize.Union


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor


{-|

  - id - ID of the droid.

-}
droid_ : { id : String } -> SelectionSet selection Normalize.Object.Droid -> FieldDecoder (Maybe selection) RootQuery
droid_ requiredArgs object =
    Object.selectionFieldDecoder "_droid" [ Argument.required "id" requiredArgs.id Encode.string ] object (identity >> Decode.maybe)


{-|

  - episode - If omitted, returns the hero of the whole saga. If provided, returns the hero of that particular episode.

-}
hero : ({ episode : OptionalArgument Normalize.Enum.Episode_.Episode_ } -> { episode : OptionalArgument Normalize.Enum.Episode_.Episode_ }) -> SelectionSet selection Normalize.Interface.Character -> FieldDecoder (Maybe selection) RootQuery
hero fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Absent }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Encode.enum Normalize.Enum.Episode_.toString) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "hero" optionalArgs object (identity >> Decode.maybe)


{-|

  - episode - If omitted, returns the hero of the whole saga. If provided, returns the hero of that particular episode.

-}
heroUnion : ({ episode : OptionalArgument Normalize.Enum.Episode_.Episode_ } -> { episode : OptionalArgument Normalize.Enum.Episode_.Episode_ }) -> SelectionSet selection Normalize.Union.CharacterUnion -> FieldDecoder (Maybe selection) RootQuery
heroUnion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { episode = Absent }

        optionalArgs =
            [ Argument.optional "episode" filledInOptionals.episode (Encode.enum Normalize.Enum.Episode_.toString) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "heroUnion" optionalArgs object (identity >> Decode.maybe)


{-|

  - id - ID of the human.

-}
hUMAN : { id : String } -> SelectionSet selection Normalize.Object.Human -> FieldDecoder (Maybe selection) RootQuery
hUMAN requiredArgs object =
    Object.selectionFieldDecoder "HUMAN" [ Argument.required "id" requiredArgs.id Encode.string ] object (identity >> Decode.maybe)
