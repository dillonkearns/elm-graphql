module Github.Interface.RepositoryNode exposing (..)

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


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.RepositoryNode
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.RepositoryNode) -> SelectionSet (a -> constructor) Github.Interface.RepositoryNode
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onCommitComment : SelectionSet selection Github.Object.CommitComment -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onCommitComment (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitComment" fields decoder


onCommitCommentThread : SelectionSet selection Github.Object.CommitCommentThread -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onCommitCommentThread (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitCommentThread" fields decoder


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onIssueComment : SelectionSet selection Github.Object.IssueComment -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onIssueComment (SelectionSet fields decoder) =
    FragmentSelectionSet "IssueComment" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onPullRequestReview : SelectionSet selection Github.Object.PullRequestReview -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onPullRequestReview (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReview" fields decoder


onPullRequestReviewComment : SelectionSet selection Github.Object.PullRequestReviewComment -> FragmentSelectionSet selection Github.Interface.RepositoryNode
onPullRequestReviewComment (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReviewComment" fields decoder


{-| The repository associated with this node.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Interface.RepositoryNode
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
