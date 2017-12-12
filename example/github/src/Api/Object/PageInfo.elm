module Api.Object.PageInfo exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PageInfo
build constructor =
    Object.object constructor


endCursor : FieldDecoder String Api.Object.PageInfo
endCursor =
    Object.fieldDecoder "endCursor" [] Decode.string


hasNextPage : FieldDecoder Bool Api.Object.PageInfo
hasNextPage =
    Object.fieldDecoder "hasNextPage" [] Decode.bool


hasPreviousPage : FieldDecoder Bool Api.Object.PageInfo
hasPreviousPage =
    Object.fieldDecoder "hasPreviousPage" [] Decode.bool


startCursor : FieldDecoder String Api.Object.PageInfo
startCursor =
    Object.fieldDecoder "startCursor" [] Decode.string
