module Api.Object.UpdatableComment exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


selection : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdatableComment
selection constructor =
    Object.object constructor


viewerCannotUpdateReasons : FieldDecoder (List String) Api.Object.UpdatableComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Decode.string |> Decode.list)
