module Api.Mutation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Document exposing (DocumentRoot)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Mutation as Mutation
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


increment : DocumentRoot Int
increment =
    Mutation.fieldDecoder "increment" [] Decode.int
