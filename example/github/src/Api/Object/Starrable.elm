module Api.Object.Starrable exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Starrable
build constructor =
    Object.object constructor


id : FieldDecoder String Api.Object.Starrable
id =
    Object.fieldDecoder "id" [] Decode.string


stargazers : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String }) -> Object stargazers Api.Object.StargazerConnection -> FieldDecoder stargazers Api.Object.Starrable
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "stargazers" optionalArgs object


viewerHasStarred : FieldDecoder Bool Api.Object.Starrable
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool
