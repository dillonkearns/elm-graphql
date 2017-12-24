module Api.Object.Blame exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Blame
selection constructor =
    Object.object constructor


ranges : FieldDecoder (List String) Api.Object.Blame
ranges =
    Object.fieldDecoder "ranges" [] (Decode.string |> Decode.list)
