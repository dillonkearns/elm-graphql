module Api.Object.RepositoryNode exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryNode
build constructor =
    Object.object constructor


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryNode
repository object =
    Object.single "repository" [] object
