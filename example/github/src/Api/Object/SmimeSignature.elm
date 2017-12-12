module Api.Object.SmimeSignature exposing (..)

import Api.Enum.GitSignatureState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.SmimeSignature
build constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.SmimeSignature
email =
    Object.fieldDecoder "email" [] Decode.string


isValid : FieldDecoder Bool Api.Object.SmimeSignature
isValid =
    Object.fieldDecoder "isValid" [] Decode.bool


payload : FieldDecoder String Api.Object.SmimeSignature
payload =
    Object.fieldDecoder "payload" [] Decode.string


signature : FieldDecoder String Api.Object.SmimeSignature
signature =
    Object.fieldDecoder "signature" [] Decode.string


signer : Object signer Api.Object.User -> FieldDecoder signer Api.Object.SmimeSignature
signer object =
    Object.single "signer" [] object


state : FieldDecoder Api.Enum.GitSignatureState.GitSignatureState Api.Object.SmimeSignature
state =
    Object.fieldDecoder "state" [] Api.Enum.GitSignatureState.decoder
