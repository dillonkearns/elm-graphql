module Api.Object.OrganizationInvitationEdge exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.OrganizationInvitationEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.OrganizationInvitationEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.OrganizationInvitation -> FieldDecoder node Api.Object.OrganizationInvitationEdge
node object =
    Object.single "node" [] object
