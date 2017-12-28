module Github.Object.SuggestedReviewer exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.SuggestedReviewer
selection constructor =
    Object.object constructor


isAuthor : FieldDecoder Bool Github.Object.SuggestedReviewer
isAuthor =
    Object.fieldDecoder "isAuthor" [] Decode.bool


isCommenter : FieldDecoder Bool Github.Object.SuggestedReviewer
isCommenter =
    Object.fieldDecoder "isCommenter" [] Decode.bool


reviewer : SelectionSet reviewer Github.Object.User -> FieldDecoder reviewer Github.Object.SuggestedReviewer
reviewer object =
    Object.selectionFieldDecoder "reviewer" [] object identity
