module Api.Object.Blame exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Blame
build constructor =
    Object.object constructor


ranges : FieldDecoder (List String) Api.Object.Blame
ranges =
    Object.fieldDecoder "ranges" [] (Decode.string |> Decode.list)
