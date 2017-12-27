module Api.Object.UnknownSignature exposing (..)

import Api.Enum.GitSignatureState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UnknownSignature
selection constructor =
    Object.object constructor


email : FieldDecoder String Api.Object.UnknownSignature
email =
    Object.fieldDecoder "email" [] Decode.string


isValid : FieldDecoder Bool Api.Object.UnknownSignature
isValid =
    Object.fieldDecoder "isValid" [] Decode.bool


payload : FieldDecoder String Api.Object.UnknownSignature
payload =
    Object.fieldDecoder "payload" [] Decode.string


signature : FieldDecoder String Api.Object.UnknownSignature
signature =
    Object.fieldDecoder "signature" [] Decode.string


signer : SelectionSet signer Api.Object.User -> FieldDecoder signer Api.Object.UnknownSignature
signer object =
    Object.single "signer" [] object


state : FieldDecoder Api.Enum.GitSignatureState.GitSignatureState Api.Object.UnknownSignature
state =
    Object.fieldDecoder "state" [] Api.Enum.GitSignatureState.decoder
