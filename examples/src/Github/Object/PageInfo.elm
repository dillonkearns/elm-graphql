module Github.Object.PageInfo exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PageInfo
selection constructor =
    Object.object constructor


endCursor : FieldDecoder String Github.Object.PageInfo
endCursor =
    Object.fieldDecoder "endCursor" [] Decode.string


hasNextPage : FieldDecoder Bool Github.Object.PageInfo
hasNextPage =
    Object.fieldDecoder "hasNextPage" [] Decode.bool


hasPreviousPage : FieldDecoder Bool Github.Object.PageInfo
hasPreviousPage =
    Object.fieldDecoder "hasPreviousPage" [] Decode.bool


startCursor : FieldDecoder String Github.Object.PageInfo
startCursor =
    Object.fieldDecoder "startCursor" [] Decode.string
