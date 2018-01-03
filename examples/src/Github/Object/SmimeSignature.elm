module Github.Object.SmimeSignature exposing (..)

import Github.Enum.GitSignatureState
import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.SmimeSignature
selection constructor =
    Object.object constructor


{-| Email used to sign this object.
-}
email : FieldDecoder String Github.Object.SmimeSignature
email =
    Object.fieldDecoder "email" [] Decode.string


{-| True if the signature is valid and verified by GitHub.
-}
isValid : FieldDecoder Bool Github.Object.SmimeSignature
isValid =
    Object.fieldDecoder "isValid" [] Decode.bool


{-| Payload for GPG signing object. Raw ODB object without the signature header.
-}
payload : FieldDecoder String Github.Object.SmimeSignature
payload =
    Object.fieldDecoder "payload" [] Decode.string


{-| ASCII-armored signature header from object.
-}
signature : FieldDecoder String Github.Object.SmimeSignature
signature =
    Object.fieldDecoder "signature" [] Decode.string


{-| GitHub user corresponding to the email signing this commit.
-}
signer : SelectionSet signer Github.Object.User -> FieldDecoder (Maybe signer) Github.Object.SmimeSignature
signer object =
    Object.selectionFieldDecoder "signer" [] object (identity >> Decode.maybe)


{-| The state of this signature. `VALID` if signature is valid and verified by GitHub, otherwise represents reason why signature is considered invalid.
-}
state : FieldDecoder Github.Enum.GitSignatureState.GitSignatureState Github.Object.SmimeSignature
state =
    Object.fieldDecoder "state" [] Github.Enum.GitSignatureState.decoder
