module Api.Object.ReviewDismissalAllowanceConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ReviewDismissalAllowanceConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ReviewDismissalAllowanceEdge) Api.Object.ReviewDismissalAllowanceConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ReviewDismissalAllowanceEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ReviewDismissalAllowance) Api.Object.ReviewDismissalAllowanceConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ReviewDismissalAllowance.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ReviewDismissalAllowanceConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ReviewDismissalAllowanceConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
