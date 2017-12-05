module Api.Object.TeamMemberEdge exposing (..)

import Api.Enum.TeamMemberRole
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.TeamMemberEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamMemberEdge
cursor =
    Field.fieldDecoder "cursor" [] Decode.string


memberAccessResourcePath : FieldDecoder String Api.Object.TeamMemberEdge
memberAccessResourcePath =
    Field.fieldDecoder "memberAccessResourcePath" [] Decode.string


memberAccessUrl : FieldDecoder String Api.Object.TeamMemberEdge
memberAccessUrl =
    Field.fieldDecoder "memberAccessUrl" [] Decode.string


node : Object node Api.Object.User -> FieldDecoder node Api.Object.TeamMemberEdge
node object =
    Object.single "node" [] object


role : FieldDecoder Api.Enum.TeamMemberRole.TeamMemberRole Api.Object.TeamMemberEdge
role =
    Field.fieldDecoder "role" [] Api.Enum.TeamMemberRole.decoder
