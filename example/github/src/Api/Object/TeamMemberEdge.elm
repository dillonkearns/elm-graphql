module Api.Object.TeamMemberEdge exposing (..)

import Api.Enum.TeamMemberRole
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.TeamMemberEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamMemberEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


memberAccessResourcePath : FieldDecoder String Api.Object.TeamMemberEdge
memberAccessResourcePath =
    Object.fieldDecoder "memberAccessResourcePath" [] Decode.string


memberAccessUrl : FieldDecoder String Api.Object.TeamMemberEdge
memberAccessUrl =
    Object.fieldDecoder "memberAccessUrl" [] Decode.string


node : SelectionSet node Api.Object.User -> FieldDecoder node Api.Object.TeamMemberEdge
node object =
    Object.single "node" [] object


role : FieldDecoder Api.Enum.TeamMemberRole.TeamMemberRole Api.Object.TeamMemberEdge
role =
    Object.fieldDecoder "role" [] Api.Enum.TeamMemberRole.decoder
