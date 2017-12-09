module Api.Object.RepositoryNode exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryNode
build constructor =
    Object.object constructor


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryNode
repository object =
    Object.single "repository" [] object
