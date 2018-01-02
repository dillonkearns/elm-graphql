module Github.Object.UniformResourceLocatable exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.UniformResourceLocatable
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Object.UniformResourceLocatable) -> SelectionSet (a -> constructor) Github.Object.UniformResourceLocatable
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onBot : SelectionSet selection Github.Object.Bot -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onBot (SelectionSet fields decoder) =
    FragmentSelectionSet "Bot" fields decoder


onCrossReferencedEvent : SelectionSet selection Github.Object.CrossReferencedEvent -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onCrossReferencedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "CrossReferencedEvent" fields decoder


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onMergedEvent : SelectionSet selection Github.Object.MergedEvent -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onMergedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MergedEvent" fields decoder


onMilestone : SelectionSet selection Github.Object.Milestone -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onMilestone (SelectionSet fields decoder) =
    FragmentSelectionSet "Milestone" fields decoder


onOrganization : SelectionSet selection Github.Object.Organization -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onPullRequestCommit : SelectionSet selection Github.Object.PullRequestCommit -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onPullRequestCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestCommit" fields decoder


onRelease : SelectionSet selection Github.Object.Release -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onRelease (SelectionSet fields decoder) =
    FragmentSelectionSet "Release" fields decoder


onRepository : SelectionSet selection Github.Object.Repository -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


onRepositoryTopic : SelectionSet selection Github.Object.RepositoryTopic -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onRepositoryTopic (SelectionSet fields decoder) =
    FragmentSelectionSet "RepositoryTopic" fields decoder


onReviewDismissedEvent : SelectionSet selection Github.Object.ReviewDismissedEvent -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onReviewDismissedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewDismissedEvent" fields decoder


onUser : SelectionSet selection Github.Object.User -> FragmentSelectionSet selection Github.Object.UniformResourceLocatable
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


{-| The HTML path to this resource.
-}
resourcePath : FieldDecoder String Github.Object.UniformResourceLocatable
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The URL to this resource.
-}
url : FieldDecoder String Github.Object.UniformResourceLocatable
url =
    Object.fieldDecoder "url" [] Decode.string
