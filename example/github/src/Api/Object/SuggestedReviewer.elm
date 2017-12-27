module Api.Object.SuggestedReviewer exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.SuggestedReviewer
selection constructor =
    Object.object constructor


isAuthor : FieldDecoder Bool Api.Object.SuggestedReviewer
isAuthor =
    Object.fieldDecoder "isAuthor" [] Decode.bool


isCommenter : FieldDecoder Bool Api.Object.SuggestedReviewer
isCommenter =
    Object.fieldDecoder "isCommenter" [] Decode.bool


reviewer : SelectionSet reviewer Api.Object.User -> FieldDecoder reviewer Api.Object.SuggestedReviewer
reviewer object =
    Object.single "reviewer" [] object
