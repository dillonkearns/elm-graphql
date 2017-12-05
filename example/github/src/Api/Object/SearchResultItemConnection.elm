module Api.Object.SearchResultItemConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SearchResultItemConnection
build constructor =
    Object.object constructor


codeCount : FieldDecoder Int Api.Object.SearchResultItemConnection
codeCount =
    Field.fieldDecoder "codeCount" [] Decode.int


edges : Object edges Api.Object.SearchResultItemEdge -> FieldDecoder (List edges) Api.Object.SearchResultItemConnection
edges object =
    Object.listOf "edges" [] object


issueCount : FieldDecoder Int Api.Object.SearchResultItemConnection
issueCount =
    Field.fieldDecoder "issueCount" [] Decode.int


nodes : FieldDecoder (List String) Api.Object.SearchResultItemConnection
nodes =
    Field.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.SearchResultItemConnection
pageInfo object =
    Object.single "pageInfo" [] object


repositoryCount : FieldDecoder Int Api.Object.SearchResultItemConnection
repositoryCount =
    Field.fieldDecoder "repositoryCount" [] Decode.int


userCount : FieldDecoder Int Api.Object.SearchResultItemConnection
userCount =
    Field.fieldDecoder "userCount" [] Decode.int


wikiCount : FieldDecoder Int Api.Object.SearchResultItemConnection
wikiCount =
    Field.fieldDecoder "wikiCount" [] Decode.int
