module Api.Object.ProjectCardConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.ProjectCardConnection
selection constructor =
    Object.object constructor


edges : Object edges Api.Object.ProjectCardEdge -> FieldDecoder (List edges) Api.Object.ProjectCardConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.ProjectCard -> FieldDecoder (List nodes) Api.Object.ProjectCardConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ProjectCardConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.ProjectCardConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int
