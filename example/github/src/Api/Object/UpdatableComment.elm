module Api.Object.UpdatableComment exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdatableComment
build constructor =
    Object.object constructor


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.UpdatableComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)
