module Api.Object.CharacterConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CharacterConnection
build constructor =
    Object.object constructor


edges : Object edges Api.Object.CharacterEdge -> FieldDecoder (List edges) Api.Object.CharacterConnection
edges object =
    Object.listOf "edges" [] object


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.CharacterConnection
pageInfo object =
    Object.single "pageInfo" [] object
