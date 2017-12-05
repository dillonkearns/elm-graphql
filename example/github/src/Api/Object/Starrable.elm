module Api.Object.Starrable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Starrable
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Starrable
id =
    Field.fieldDecoder "id" [] Decode.string


stargazers : Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Starrable
stargazers object =
    Object.single "stargazers" [] object


viewerHasStarred : FieldDecoder Bool Api.Object.Starrable
viewerHasStarred =
    Field.fieldDecoder "viewerHasStarred" [] Decode.bool
