module Api.Object.GpgSignature exposing (..)

import Api.Enum.GitSignatureState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GpgSignature
build constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.GpgSignature
email =
    Field.fieldDecoder "email" [] Decode.string


isValid : FieldDecoder Bool Api.Object.GpgSignature
isValid =
    Field.fieldDecoder "isValid" [] Decode.bool


keyId : FieldDecoder String Api.Object.GpgSignature
keyId =
    Field.fieldDecoder "keyId" [] Decode.string


payload : FieldDecoder String Api.Object.GpgSignature
payload =
    Field.fieldDecoder "payload" [] Decode.string


signature : FieldDecoder String Api.Object.GpgSignature
signature =
    Field.fieldDecoder "signature" [] Decode.string


signer : Object signer Api.Object.User -> FieldDecoder signer Api.Object.GpgSignature
signer object =
    Object.single "signer" [] object


state : FieldDecoder Api.Enum.GitSignatureState.GitSignatureState Api.Object.GpgSignature
state =
    Field.fieldDecoder "state" [] Api.Enum.GitSignatureState.decoder
