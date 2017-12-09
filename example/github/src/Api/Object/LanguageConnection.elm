module Api.Object.LanguageConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


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
