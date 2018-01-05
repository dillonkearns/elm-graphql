module Github.Interface.Deletable exposing (..)

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
commonSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.Deletable
commonSelection constructor =
    Object.object constructor


{-| Select both common and type-specific fields from the interface.
-}
selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.Deletable) -> SelectionSet (a -> constructor) Github.Interface.Deletable
selection constructor typeSpecificDecoders =
    Object.interfaceSelection typeSpecificDecoders constructor


onCommitComment : SelectionSet selection Github.Object.CommitComment -> FragmentSelectionSet selection Github.Interface.Deletable
onCommitComment (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitComment" fields decoder


onGistComment : SelectionSet selection Github.Object.GistComment -> FragmentSelectionSet selection Github.Interface.Deletable
onGistComment (SelectionSet fields decoder) =
    FragmentSelectionSet "GistComment" fields decoder


onIssueComment : SelectionSet selection Github.Object.IssueComment -> FragmentSelectionSet selection Github.Interface.Deletable
onIssueComment (SelectionSet fields decoder) =
    FragmentSelectionSet "IssueComment" fields decoder


onPullRequestReview : SelectionSet selection Github.Object.PullRequestReview -> FragmentSelectionSet selection Github.Interface.Deletable
onPullRequestReview (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReview" fields decoder


onPullRequestReviewComment : SelectionSet selection Github.Object.PullRequestReviewComment -> FragmentSelectionSet selection Github.Interface.Deletable
onPullRequestReviewComment (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReviewComment" fields decoder


{-| Check if the current viewer can delete this object.
-}
viewerCanDelete : FieldDecoder Bool Github.Interface.Deletable
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool
