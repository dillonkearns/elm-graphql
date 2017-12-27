module Api.Object.GistCommentEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.GistCommentEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.GistCommentEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.GistComment -> FieldDecoder node Api.Object.GistCommentEdge
node object =
    Object.single "node" [] object
