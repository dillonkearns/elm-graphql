module Api.Object.PageInfo exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.PageInfo
build constructor =
    Object.object constructor


endCursor : FieldDecoder String Api.Object.PageInfo
endCursor =
    Field.fieldDecoder "endCursor" [] Decode.string


hasNextPage : FieldDecoder Bool Api.Object.PageInfo
hasNextPage =
    Field.fieldDecoder "hasNextPage" [] Decode.bool


hasPreviousPage : FieldDecoder Bool Api.Object.PageInfo
hasPreviousPage =
    Field.fieldDecoder "hasPreviousPage" [] Decode.bool


startCursor : FieldDecoder String Api.Object.PageInfo
startCursor =
    Field.fieldDecoder "startCursor" [] Decode.string
