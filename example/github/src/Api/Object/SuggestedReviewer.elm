module Api.Object.SuggestedReviewer exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SuggestedReviewer
build constructor =
    Object.object constructor


isAuthor : FieldDecoder Bool Api.Object.SuggestedReviewer
isAuthor =
    Field.fieldDecoder "isAuthor" [] Decode.bool


isCommenter : FieldDecoder Bool Api.Object.SuggestedReviewer
isCommenter =
    Field.fieldDecoder "isCommenter" [] Decode.bool


reviewer : Object reviewer Api.Object.User -> FieldDecoder reviewer Api.Object.SuggestedReviewer
reviewer object =
    Object.single "reviewer" [] object
