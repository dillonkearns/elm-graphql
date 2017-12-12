module Api.Object.PageInfo exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


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
