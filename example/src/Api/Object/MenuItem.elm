module Api.Object.MenuItem exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.MenuItem
selection constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.MenuItem
description =
    Object.fieldDecoder "description" [] Decode.string


id : FieldDecoder String Api.Object.MenuItem
id =
    Object.fieldDecoder "id" [] Decode.string


name : FieldDecoder String Api.Object.MenuItem
name =
    Object.fieldDecoder "name" [] Decode.string
