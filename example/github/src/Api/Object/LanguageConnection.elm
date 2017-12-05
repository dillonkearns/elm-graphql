module Api.Object.LanguageConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.LanguageConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.LanguageEdge) Api.Object.LanguageConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.LanguageEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.Language) Api.Object.LanguageConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.Language.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.LanguageConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.LanguageConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string


totalSize : FieldDecoder String Api.Object.LanguageConnection
totalSize =
    Field.fieldDecoder "totalSize" [] Decode.string
