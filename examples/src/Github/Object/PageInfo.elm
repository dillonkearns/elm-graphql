module Github.Object.PageInfo exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.PageInfo
selection constructor =
    Object.selection constructor


{-| When paginating forwards, the cursor to continue.
-}
endCursor : FieldDecoder (Maybe String) Github.Object.PageInfo
endCursor =
    Object.fieldDecoder "endCursor" [] (Decode.string |> Decode.maybe)


{-| When paginating forwards, are there more items?
-}
hasNextPage : FieldDecoder Bool Github.Object.PageInfo
hasNextPage =
    Object.fieldDecoder "hasNextPage" [] Decode.bool


{-| When paginating backwards, are there more items?
-}
hasPreviousPage : FieldDecoder Bool Github.Object.PageInfo
hasPreviousPage =
    Object.fieldDecoder "hasPreviousPage" [] Decode.bool


{-| When paginating backwards, the cursor to continue.
-}
startCursor : FieldDecoder (Maybe String) Github.Object.PageInfo
startCursor =
    Object.fieldDecoder "startCursor" [] (Decode.string |> Decode.maybe)
