module Api.Object.ExternalIdentityConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ExternalIdentityConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.ExternalIdentityEdge) Api.Object.ExternalIdentityConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.ExternalIdentityEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.ExternalIdentity) Api.Object.ExternalIdentityConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.ExternalIdentity.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.ExternalIdentityConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.ExternalIdentityConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
