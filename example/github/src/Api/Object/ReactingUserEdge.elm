module Api.Object.ReactingUserEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReactingUserEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReactingUserEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.User -> FieldDecoder node Api.Object.ReactingUserEdge
node object =
    Object.single "node" [] object


reactedAt : FieldDecoder String Api.Object.ReactingUserEdge
reactedAt =
    Object.fieldDecoder "reactedAt" [] Decode.string
