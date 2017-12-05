module Api.Object.Assignable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Assignable
build constructor =
    Object.object constructor


assignees : Object assignees Api.Object.UserConnection -> FieldDecoder assignees Api.Object.Assignable
assignees object =
    Object.single "assignees" [] object
