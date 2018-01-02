module Github.Object.Subscribable exposing (..)

import Github.Enum.SubscriptionState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Subscribable
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Object.Subscribable) -> SelectionSet (a -> constructor) Github.Object.Subscribable
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onCommit : SelectionSet selection Github.Object.Commit -> FragmentSelectionSet selection Github.Object.Subscribable
onCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "Commit" fields decoder


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Object.Subscribable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Object.Subscribable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onRepository : SelectionSet selection Github.Object.Repository -> FragmentSelectionSet selection Github.Object.Subscribable
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


onTeam : SelectionSet selection Github.Object.Team -> FragmentSelectionSet selection Github.Object.Subscribable
onTeam (SelectionSet fields decoder) =
    FragmentSelectionSet "Team" fields decoder


id : FieldDecoder String Github.Object.Subscribable
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Check if the viewer is able to change their subscription status for the repository.
-}
viewerCanSubscribe : FieldDecoder Bool Github.Object.Subscribable
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


{-| Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
-}
viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Subscribable
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder
