module Api.Object.ReviewRequestConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewRequestConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ReviewRequestEdge) Api.Object.ReviewRequestConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ReviewRequestEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ReviewRequest) Api.Object.ReviewRequestConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ReviewRequest.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReviewRequestConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ReviewRequestConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
