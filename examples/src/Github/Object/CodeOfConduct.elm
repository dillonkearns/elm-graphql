module Github.Object.CodeOfConduct exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CodeOfConduct
selection constructor =
    Object.object constructor


{-| The body of the CoC
-}
body : FieldDecoder (Maybe String) Github.Object.CodeOfConduct
body =
    Object.fieldDecoder "body" [] (Decode.string |> Decode.maybe)


{-| The key for the CoC
-}
key : FieldDecoder String Github.Object.CodeOfConduct
key =
    Object.fieldDecoder "key" [] Decode.string


{-| The formal name of the CoC
-}
name : FieldDecoder String Github.Object.CodeOfConduct
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The path to the CoC
-}
url : FieldDecoder (Maybe String) Github.Object.CodeOfConduct
url =
    Object.fieldDecoder "url" [] (Decode.string |> Decode.maybe)
