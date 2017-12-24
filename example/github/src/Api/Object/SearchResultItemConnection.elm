module Api.Object.SearchResultItemConnection exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.SearchResultItemConnection
selection constructor =
    Object.object constructor


codeCount : FieldDecoder Int Api.Object.SearchResultItemConnection
codeCount =
    Object.fieldDecoder "codeCount" [] Decode.int


edges : Object edges Api.Object.SearchResultItemEdge -> FieldDecoder (List edges) Api.Object.SearchResultItemConnection
edges object =
    Object.listOf "edges" [] object


issueCount : FieldDecoder Int Api.Object.SearchResultItemConnection
issueCount =
    Object.fieldDecoder "issueCount" [] Decode.int


nodes : FieldDecoder (List String) Api.Object.SearchResultItemConnection
nodes =
    Object.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.SearchResultItemConnection
pageInfo object =
    Object.single "pageInfo" [] object


repositoryCount : FieldDecoder Int Api.Object.SearchResultItemConnection
repositoryCount =
    Object.fieldDecoder "repositoryCount" [] Decode.int


userCount : FieldDecoder Int Api.Object.SearchResultItemConnection
userCount =
    Object.fieldDecoder "userCount" [] Decode.int


wikiCount : FieldDecoder Int Api.Object.SearchResultItemConnection
wikiCount =
    Object.fieldDecoder "wikiCount" [] Decode.int
