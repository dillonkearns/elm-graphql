module Api.Object.RepositoryCollaboratorConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryCollaboratorConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.RepositoryCollaboratorEdge) Api.Object.RepositoryCollaboratorConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.RepositoryCollaboratorEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.User) Api.Object.RepositoryCollaboratorConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.User.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.RepositoryCollaboratorConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.RepositoryCollaboratorConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
