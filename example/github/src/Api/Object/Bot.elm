module Api.Object.Bot exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Bot
selection constructor =
    Object.object constructor


avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Api.Object.Bot
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


createdAt : FieldDecoder String Api.Object.Bot
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder Int Api.Object.Bot
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


id : FieldDecoder String Api.Object.Bot
id =
    Object.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.Bot
login =
    Object.fieldDecoder "login" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Bot
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Bot
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Bot
url =
    Object.fieldDecoder "url" [] Decode.string
