module Api.Object.ReviewDismissalAllowanceEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ReviewDismissalAllowanceEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.ReviewDismissalAllowanceEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.ReviewDismissalAllowance -> FieldDecoder node Api.Object.ReviewDismissalAllowanceEdge
node object =
    Object.single "node" [] object
