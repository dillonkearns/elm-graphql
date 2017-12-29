module Github.Object.Blame exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Blame
selection constructor =
    Object.object constructor


{-| The list of ranges from a Git blame.
-}
ranges : SelectionSet ranges Github.Object.BlameRange -> FieldDecoder (List ranges) Github.Object.Blame
ranges object =
    Object.selectionFieldDecoder "ranges" [] object (identity >> Decode.list)
