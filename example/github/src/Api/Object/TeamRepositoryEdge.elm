module Api.Object.TeamRepositoryEdge exposing (..)

import Api.Enum.RepositoryPermission
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.TeamRepositoryEdge
selection constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.TeamRepositoryEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : SelectionSet node Api.Object.Repository -> FieldDecoder node Api.Object.TeamRepositoryEdge
node object =
    Object.single "node" [] object


permission : FieldDecoder Api.Enum.RepositoryPermission.RepositoryPermission Api.Object.TeamRepositoryEdge
permission =
    Object.fieldDecoder "permission" [] Api.Enum.RepositoryPermission.decoder
