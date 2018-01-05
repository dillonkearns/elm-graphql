module Github.Interface.GitSignature exposing (..)

import Github.Enum.GitSignatureState
import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


{-| Select only common fields from the interface.
-}
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.GitSignature
commonSelection constructor =
    Object.object constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.GitSignature) -> SelectionSet (a -> constructor) Github.Interface.GitSignature
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onGpgSignature : SelectionSet selection Github.Object.GpgSignature -> FragmentSelectionSet selection Github.Interface.GitSignature
onGpgSignature (SelectionSet fields decoder) =
    FragmentSelectionSet "GpgSignature" fields decoder


onSmimeSignature : SelectionSet selection Github.Object.SmimeSignature -> FragmentSelectionSet selection Github.Interface.GitSignature
onSmimeSignature (SelectionSet fields decoder) =
    FragmentSelectionSet "SmimeSignature" fields decoder


onUnknownSignature : SelectionSet selection Github.Object.UnknownSignature -> FragmentSelectionSet selection Github.Interface.GitSignature
onUnknownSignature (SelectionSet fields decoder) =
    FragmentSelectionSet "UnknownSignature" fields decoder


{-| Email used to sign this object.
-}
email : FieldDecoder String Github.Interface.GitSignature
email =
    Object.fieldDecoder "email" [] Decode.string


{-| True if the signature is valid and verified by GitHub.
-}
isValid : FieldDecoder Bool Github.Interface.GitSignature
isValid =
    Object.fieldDecoder "isValid" [] Decode.bool


{-| Payload for GPG signing object. Raw ODB object without the signature header.
-}
payload : FieldDecoder String Github.Interface.GitSignature
payload =
    Object.fieldDecoder "payload" [] Decode.string


{-| ASCII-armored signature header from object.
-}
signature : FieldDecoder String Github.Interface.GitSignature
signature =
    Object.fieldDecoder "signature" [] Decode.string


{-| GitHub user corresponding to the email signing this commit.
-}
signer : SelectionSet selection Github.Object.User -> FieldDecoder (Maybe selection) Github.Interface.GitSignature
signer object =
    Object.selectionFieldDecoder "signer" [] object (identity >> Decode.maybe)


{-| The state of this signature. `VALID` if signature is valid and verified by GitHub, otherwise represents reason why signature is considered invalid.
-}
state : FieldDecoder Github.Enum.GitSignatureState.GitSignatureState Github.Interface.GitSignature
state =
    Object.fieldDecoder "state" [] Github.Enum.GitSignatureState.decoder
