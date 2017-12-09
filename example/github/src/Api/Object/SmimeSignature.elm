module Api.Object.SmimeSignature exposing (..)

import Api.Enum.GitSignatureState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


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
