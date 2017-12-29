module Github.Object.CodeOfConduct exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CodeOfConduct
selection constructor =
    Object.object constructor


body : FieldDecoder (Maybe String) Github.Object.CodeOfConduct
body =
    Object.fieldDecoder "body" [] (Decode.string |> Decode.maybe)


key : FieldDecoder String Github.Object.CodeOfConduct
key =
    Object.fieldDecoder "key" [] Decode.string


name : FieldDecoder String Github.Object.CodeOfConduct
name =
    Object.fieldDecoder "name" [] Decode.string


url : FieldDecoder (Maybe String) Github.Object.CodeOfConduct
url =
    Object.fieldDecoder "url" [] (Decode.string |> Decode.maybe)
