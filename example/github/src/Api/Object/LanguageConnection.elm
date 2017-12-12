module Api.Object.LanguageConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LanguageConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.LanguageEdge -> FieldDecoder (List edges) Api.Object.LanguageConnection
edges object =
    Object.listOf "edges" [] object


nodes : Object nodes Api.Object.Language -> FieldDecoder (List nodes) Api.Object.LanguageConnection
nodes object =
    Object.listOf "nodes" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.LanguageConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder Int Api.Object.LanguageConnection
totalCount =
    Object.fieldDecoder "totalCount" [] Decode.int


totalSize : FieldDecoder Int Api.Object.LanguageConnection
totalSize =
    Object.fieldDecoder "totalSize" [] Decode.int
