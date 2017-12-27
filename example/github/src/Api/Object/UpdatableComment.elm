module Api.Object.UpdatableComment exposing (..)

import Api.Enum.CommentCannotUpdateReason
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UpdatableComment
selection constructor =
    Object.object constructor


viewerCannotUpdateReasons : FieldDecoder (List Api.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Api.Object.UpdatableComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Api.Enum.CommentCannotUpdateReason.decoder |> Decode.list)
