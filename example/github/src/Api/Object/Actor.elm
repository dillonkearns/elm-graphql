module Api.Object.Actor exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Actor
build constructor =
    Object.object constructor


avatarUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.Actor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


login : FieldDecoder String Api.Object.Actor
login =
    Object.fieldDecoder "login" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Actor
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.Actor
url =
    Object.fieldDecoder "url" [] Decode.string
