module Api.Object.UnknownSignature exposing (..)

import Api.Enum.GitSignatureState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.UnknownSignature
build constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.UnknownSignature
email =
    Field.fieldDecoder "email" [] Decode.string


isValid : FieldDecoder String Api.Object.UnknownSignature
isValid =
    Field.fieldDecoder "isValid" [] Decode.string


payload : FieldDecoder String Api.Object.UnknownSignature
payload =
    Field.fieldDecoder "payload" [] Decode.string


signature : FieldDecoder String Api.Object.UnknownSignature
signature =
    Field.fieldDecoder "signature" [] Decode.string


signer : Object signer Api.Object.User -> FieldDecoder signer Api.Object.UnknownSignature
signer object =
    Object.single "signer" [] object


state : FieldDecoder Api.Enum.GitSignatureState.GitSignatureState Api.Object.UnknownSignature
state =
    Field.fieldDecoder "state" [] Api.Enum.GitSignatureState.decoder
