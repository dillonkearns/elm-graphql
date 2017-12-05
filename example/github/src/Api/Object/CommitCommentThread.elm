module Api.Object.CommitCommentThread exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.CommitCommentThread
build constructor =
    Object.object constructor


comments : Object comments Api.Object.CommitCommentConnection -> FieldDecoder comments Api.Object.CommitCommentThread
comments object =
    Object.single "comments" [] object


commit : Object commit Api.Object.Commit -> FieldDecoder commit Api.Object.CommitCommentThread
commit object =
    Object.single "commit" [] object


id : FieldDecoder String Api.Object.CommitCommentThread
id =
    Field.fieldDecoder "id" [] Decode.string


path : FieldDecoder String Api.Object.CommitCommentThread
path =
    Field.fieldDecoder "path" [] Decode.string


position : FieldDecoder Int Api.Object.CommitCommentThread
position =
    Field.fieldDecoder "position" [] Decode.int


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.CommitCommentThread
repository object =
    Object.single "repository" [] object
