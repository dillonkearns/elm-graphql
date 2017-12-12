module Api.Object.Status exposing (..)

import Api.Enum.StatusState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Status
build constructor =
    Object.object constructor


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.Status
commit object =
    Object.single "commit" [] object


context : { name : String } -> Object context Api.Object.StatusContext -> FieldDecoder context Api.Object.Status
context requiredArgs object =
    Object.single "context" [ Argument.string "name" requiredArgs.name ] object


contexts : FieldDecoder (List String) Api.Object.Status
contexts =
    Object.fieldDecoder "contexts" [] (Decode.string |> Decode.list)


id : FieldDecoder String Api.Object.Status
id =
    Object.fieldDecoder "id" [] Decode.string


state : FieldDecoder Api.Enum.StatusState.StatusState Api.Object.Status
state =
    Object.fieldDecoder "state" [] Api.Enum.StatusState.decoder
