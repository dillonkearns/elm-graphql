module Api.Object.SearchResultItemConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SearchResultItemConnection
build constructor =
    Object.object constructor


codeCount : FieldDecoder String Api.Object.SearchResultItemConnection
codeCount =
    Field.fieldDecoder "codeCount" [] Decode.string


edges : FieldDecoder (List Object.SearchResultItemEdge) Api.Object.SearchResultItemConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.SearchResultItemEdge.decoder |> Decode.list)


issueCount : FieldDecoder String Api.Object.SearchResultItemConnection
issueCount =
    Field.fieldDecoder "issueCount" [] Decode.string


nodes : FieldDecoder (List String) Api.Object.SearchResultItemConnection
nodes =
    Field.fieldDecoder "nodes" [] (Decode.string |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.SearchResultItemConnection
pageInfo object =
    Object.single "pageInfo" [] object


repositoryCount : FieldDecoder String Api.Object.SearchResultItemConnection
repositoryCount =
    Field.fieldDecoder "repositoryCount" [] Decode.string


userCount : FieldDecoder String Api.Object.SearchResultItemConnection
userCount =
    Field.fieldDecoder "userCount" [] Decode.string


wikiCount : FieldDecoder String Api.Object.SearchResultItemConnection
wikiCount =
    Field.fieldDecoder "wikiCount" [] Decode.string
