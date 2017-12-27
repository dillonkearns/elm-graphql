module Github.Object.OrganizationInvitationEdge exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.OrganizationInvitationEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Github.Object.OrganizationInvitationEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Github.Object.OrganizationInvitation -> FieldDecoder node Github.Object.OrganizationInvitationEdge
node object =
    Object.single "node" [] object
