module Github.Object.UpdateTopicsPayload exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UpdateTopicsPayload
selection constructor =
    Object.object constructor


{-| A unique identifier for the client performing the mutation.
-}
clientMutationId : FieldDecoder (Maybe String) Github.Object.UpdateTopicsPayload
clientMutationId =
    Object.fieldDecoder "clientMutationId" [] (Decode.string |> Decode.maybe)


{-| Names of the provided topics that are not valid.
-}
invalidTopicNames : FieldDecoder (Maybe (List String)) Github.Object.UpdateTopicsPayload
invalidTopicNames =
    Object.fieldDecoder "invalidTopicNames" [] (Decode.string |> Decode.list |> Decode.maybe)


{-| The updated repository.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.UpdateTopicsPayload
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
