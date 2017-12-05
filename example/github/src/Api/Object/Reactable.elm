module Api.Object.Reactable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Reactable
build constructor =
    Object.object constructor


databaseId : FieldDecoder String Api.Object.Reactable
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


id : FieldDecoder String Api.Object.Reactable
id =
    Field.fieldDecoder "id" [] Decode.string


reactionGroups : FieldDecoder (List Object.ReactionGroup) Api.Object.Reactable
reactionGroups =
    Field.fieldDecoder "reactionGroups" [] (Api.Object.ReactionGroup.decoder |> Decode.list)


reactions : Object reactions Api.Object.ReactionConnection -> FieldDecoder reactions Api.Object.Reactable
reactions object =
    Object.single "reactions" [] object


viewerCanReact : FieldDecoder String Api.Object.Reactable
viewerCanReact =
    Field.fieldDecoder "viewerCanReact" [] Decode.string
