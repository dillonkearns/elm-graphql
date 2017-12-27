module Github.Object.DeployKey exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeployKey
selection constructor =
    Object.object constructor


createdAt : FieldDecoder String Github.Object.DeployKey
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.DeployKey
id =
    Object.fieldDecoder "id" [] Decode.string


key : FieldDecoder String Github.Object.DeployKey
key =
    Object.fieldDecoder "key" [] Decode.string


readOnly : FieldDecoder Bool Github.Object.DeployKey
readOnly =
    Object.fieldDecoder "readOnly" [] Decode.bool


title : FieldDecoder String Github.Object.DeployKey
title =
    Object.fieldDecoder "title" [] Decode.string


verified : FieldDecoder Bool Github.Object.DeployKey
verified =
    Object.fieldDecoder "verified" [] Decode.bool
