module Github.Object.DeployKey exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.DeployKey
selection constructor =
    Object.object constructor


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.DeployKey
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


id : FieldDecoder String Github.Object.DeployKey
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The deploy key.
-}
key : FieldDecoder String Github.Object.DeployKey
key =
    Object.fieldDecoder "key" [] Decode.string


{-| Whether or not the deploy key is read only.
-}
readOnly : FieldDecoder Bool Github.Object.DeployKey
readOnly =
    Object.fieldDecoder "readOnly" [] Decode.bool


{-| The deploy key title.
-}
title : FieldDecoder String Github.Object.DeployKey
title =
    Object.fieldDecoder "title" [] Decode.string


{-| Whether or not the deploy key has been verified.
-}
verified : FieldDecoder Bool Github.Object.DeployKey
verified =
    Object.fieldDecoder "verified" [] Decode.bool
