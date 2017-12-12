module Api.Object.UpdateTopicsPayload exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UpdateTopicsPayload
build constructor =
    Object.object constructor


clientMutationId : FieldDecoder String Api.Object.UpdateTopicsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] Decode.string


invalidTopicNames : FieldDecoder (List String) Api.Object.UpdateTopicsPayload
invalidTopicNames =
    Object.fieldDecoder "invalidTopicNames" [] (Decode.string |> Decode.list)


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.UpdateTopicsPayload
repository object =
    Object.single "repository" [] object
