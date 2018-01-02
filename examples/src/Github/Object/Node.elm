module Github.Object.Node exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Node
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Object.Node) -> SelectionSet (a -> constructor) Github.Object.Node
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onAddedToProjectEvent : SelectionSet selection Github.Object.AddedToProjectEvent -> FragmentSelectionSet selection Github.Object.Node
onAddedToProjectEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "AddedToProjectEvent" fields decoder


onAssignedEvent : SelectionSet selection Github.Object.AssignedEvent -> FragmentSelectionSet selection Github.Object.Node
onAssignedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "AssignedEvent" fields decoder


onBaseRefChangedEvent : SelectionSet selection Github.Object.BaseRefChangedEvent -> FragmentSelectionSet selection Github.Object.Node
onBaseRefChangedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "BaseRefChangedEvent" fields decoder


onBaseRefForcePushedEvent : SelectionSet selection Github.Object.BaseRefForcePushedEvent -> FragmentSelectionSet selection Github.Object.Node
onBaseRefForcePushedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "BaseRefForcePushedEvent" fields decoder


onBlob : SelectionSet selection Github.Object.Blob -> FragmentSelectionSet selection Github.Object.Node
onBlob (SelectionSet fields decoder) =
    FragmentSelectionSet "Blob" fields decoder


onBot : SelectionSet selection Github.Object.Bot -> FragmentSelectionSet selection Github.Object.Node
onBot (SelectionSet fields decoder) =
    FragmentSelectionSet "Bot" fields decoder


onClosedEvent : SelectionSet selection Github.Object.ClosedEvent -> FragmentSelectionSet selection Github.Object.Node
onClosedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ClosedEvent" fields decoder


onCommentDeletedEvent : SelectionSet selection Github.Object.CommentDeletedEvent -> FragmentSelectionSet selection Github.Object.Node
onCommentDeletedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "CommentDeletedEvent" fields decoder


onCommit : SelectionSet selection Github.Object.Commit -> FragmentSelectionSet selection Github.Object.Node
onCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "Commit" fields decoder


onCommitComment : SelectionSet selection Github.Object.CommitComment -> FragmentSelectionSet selection Github.Object.Node
onCommitComment (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitComment" fields decoder


onCommitCommentThread : SelectionSet selection Github.Object.CommitCommentThread -> FragmentSelectionSet selection Github.Object.Node
onCommitCommentThread (SelectionSet fields decoder) =
    FragmentSelectionSet "CommitCommentThread" fields decoder


onConvertedNoteToIssueEvent : SelectionSet selection Github.Object.ConvertedNoteToIssueEvent -> FragmentSelectionSet selection Github.Object.Node
onConvertedNoteToIssueEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ConvertedNoteToIssueEvent" fields decoder


onCrossReferencedEvent : SelectionSet selection Github.Object.CrossReferencedEvent -> FragmentSelectionSet selection Github.Object.Node
onCrossReferencedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "CrossReferencedEvent" fields decoder


onDemilestonedEvent : SelectionSet selection Github.Object.DemilestonedEvent -> FragmentSelectionSet selection Github.Object.Node
onDemilestonedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "DemilestonedEvent" fields decoder


onDeployKey : SelectionSet selection Github.Object.DeployKey -> FragmentSelectionSet selection Github.Object.Node
onDeployKey (SelectionSet fields decoder) =
    FragmentSelectionSet "DeployKey" fields decoder


onDeployedEvent : SelectionSet selection Github.Object.DeployedEvent -> FragmentSelectionSet selection Github.Object.Node
onDeployedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "DeployedEvent" fields decoder


onDeployment : SelectionSet selection Github.Object.Deployment -> FragmentSelectionSet selection Github.Object.Node
onDeployment (SelectionSet fields decoder) =
    FragmentSelectionSet "Deployment" fields decoder


onDeploymentStatus : SelectionSet selection Github.Object.DeploymentStatus -> FragmentSelectionSet selection Github.Object.Node
onDeploymentStatus (SelectionSet fields decoder) =
    FragmentSelectionSet "DeploymentStatus" fields decoder


onExternalIdentity : SelectionSet selection Github.Object.ExternalIdentity -> FragmentSelectionSet selection Github.Object.Node
onExternalIdentity (SelectionSet fields decoder) =
    FragmentSelectionSet "ExternalIdentity" fields decoder


onGist : SelectionSet selection Github.Object.Gist -> FragmentSelectionSet selection Github.Object.Node
onGist (SelectionSet fields decoder) =
    FragmentSelectionSet "Gist" fields decoder


onGistComment : SelectionSet selection Github.Object.GistComment -> FragmentSelectionSet selection Github.Object.Node
onGistComment (SelectionSet fields decoder) =
    FragmentSelectionSet "GistComment" fields decoder


onHeadRefDeletedEvent : SelectionSet selection Github.Object.HeadRefDeletedEvent -> FragmentSelectionSet selection Github.Object.Node
onHeadRefDeletedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "HeadRefDeletedEvent" fields decoder


onHeadRefForcePushedEvent : SelectionSet selection Github.Object.HeadRefForcePushedEvent -> FragmentSelectionSet selection Github.Object.Node
onHeadRefForcePushedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "HeadRefForcePushedEvent" fields decoder


onHeadRefRestoredEvent : SelectionSet selection Github.Object.HeadRefRestoredEvent -> FragmentSelectionSet selection Github.Object.Node
onHeadRefRestoredEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "HeadRefRestoredEvent" fields decoder


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Object.Node
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onIssueComment : SelectionSet selection Github.Object.IssueComment -> FragmentSelectionSet selection Github.Object.Node
onIssueComment (SelectionSet fields decoder) =
    FragmentSelectionSet "IssueComment" fields decoder


onLabel : SelectionSet selection Github.Object.Label -> FragmentSelectionSet selection Github.Object.Node
onLabel (SelectionSet fields decoder) =
    FragmentSelectionSet "Label" fields decoder


onLabeledEvent : SelectionSet selection Github.Object.LabeledEvent -> FragmentSelectionSet selection Github.Object.Node
onLabeledEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "LabeledEvent" fields decoder


onLanguage : SelectionSet selection Github.Object.Language -> FragmentSelectionSet selection Github.Object.Node
onLanguage (SelectionSet fields decoder) =
    FragmentSelectionSet "Language" fields decoder


onLockedEvent : SelectionSet selection Github.Object.LockedEvent -> FragmentSelectionSet selection Github.Object.Node
onLockedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "LockedEvent" fields decoder


onMarketplaceListing : SelectionSet selection Github.Object.MarketplaceListing -> FragmentSelectionSet selection Github.Object.Node
onMarketplaceListing (SelectionSet fields decoder) =
    FragmentSelectionSet "MarketplaceListing" fields decoder


onMentionedEvent : SelectionSet selection Github.Object.MentionedEvent -> FragmentSelectionSet selection Github.Object.Node
onMentionedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MentionedEvent" fields decoder


onMergedEvent : SelectionSet selection Github.Object.MergedEvent -> FragmentSelectionSet selection Github.Object.Node
onMergedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MergedEvent" fields decoder


onMilestone : SelectionSet selection Github.Object.Milestone -> FragmentSelectionSet selection Github.Object.Node
onMilestone (SelectionSet fields decoder) =
    FragmentSelectionSet "Milestone" fields decoder


onMilestonedEvent : SelectionSet selection Github.Object.MilestonedEvent -> FragmentSelectionSet selection Github.Object.Node
onMilestonedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MilestonedEvent" fields decoder


onMovedColumnsInProjectEvent : SelectionSet selection Github.Object.MovedColumnsInProjectEvent -> FragmentSelectionSet selection Github.Object.Node
onMovedColumnsInProjectEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "MovedColumnsInProjectEvent" fields decoder


onOrganization : SelectionSet selection Github.Object.Organization -> FragmentSelectionSet selection Github.Object.Node
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onOrganizationIdentityProvider : SelectionSet selection Github.Object.OrganizationIdentityProvider -> FragmentSelectionSet selection Github.Object.Node
onOrganizationIdentityProvider (SelectionSet fields decoder) =
    FragmentSelectionSet "OrganizationIdentityProvider" fields decoder


onOrganizationInvitation : SelectionSet selection Github.Object.OrganizationInvitation -> FragmentSelectionSet selection Github.Object.Node
onOrganizationInvitation (SelectionSet fields decoder) =
    FragmentSelectionSet "OrganizationInvitation" fields decoder


onProject : SelectionSet selection Github.Object.Project -> FragmentSelectionSet selection Github.Object.Node
onProject (SelectionSet fields decoder) =
    FragmentSelectionSet "Project" fields decoder


onProjectCard : SelectionSet selection Github.Object.ProjectCard -> FragmentSelectionSet selection Github.Object.Node
onProjectCard (SelectionSet fields decoder) =
    FragmentSelectionSet "ProjectCard" fields decoder


onProjectColumn : SelectionSet selection Github.Object.ProjectColumn -> FragmentSelectionSet selection Github.Object.Node
onProjectColumn (SelectionSet fields decoder) =
    FragmentSelectionSet "ProjectColumn" fields decoder


onProtectedBranch : SelectionSet selection Github.Object.ProtectedBranch -> FragmentSelectionSet selection Github.Object.Node
onProtectedBranch (SelectionSet fields decoder) =
    FragmentSelectionSet "ProtectedBranch" fields decoder


onPublicKey : SelectionSet selection Github.Object.PublicKey -> FragmentSelectionSet selection Github.Object.Node
onPublicKey (SelectionSet fields decoder) =
    FragmentSelectionSet "PublicKey" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Object.Node
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onPullRequestCommit : SelectionSet selection Github.Object.PullRequestCommit -> FragmentSelectionSet selection Github.Object.Node
onPullRequestCommit (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestCommit" fields decoder


onPullRequestReview : SelectionSet selection Github.Object.PullRequestReview -> FragmentSelectionSet selection Github.Object.Node
onPullRequestReview (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReview" fields decoder


onPullRequestReviewComment : SelectionSet selection Github.Object.PullRequestReviewComment -> FragmentSelectionSet selection Github.Object.Node
onPullRequestReviewComment (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReviewComment" fields decoder


onPullRequestReviewThread : SelectionSet selection Github.Object.PullRequestReviewThread -> FragmentSelectionSet selection Github.Object.Node
onPullRequestReviewThread (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequestReviewThread" fields decoder


onPushAllowance : SelectionSet selection Github.Object.PushAllowance -> FragmentSelectionSet selection Github.Object.Node
onPushAllowance (SelectionSet fields decoder) =
    FragmentSelectionSet "PushAllowance" fields decoder


onReaction : SelectionSet selection Github.Object.Reaction -> FragmentSelectionSet selection Github.Object.Node
onReaction (SelectionSet fields decoder) =
    FragmentSelectionSet "Reaction" fields decoder


onRef : SelectionSet selection Github.Object.Ref -> FragmentSelectionSet selection Github.Object.Node
onRef (SelectionSet fields decoder) =
    FragmentSelectionSet "Ref" fields decoder


onReferencedEvent : SelectionSet selection Github.Object.ReferencedEvent -> FragmentSelectionSet selection Github.Object.Node
onReferencedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReferencedEvent" fields decoder


onRelease : SelectionSet selection Github.Object.Release -> FragmentSelectionSet selection Github.Object.Node
onRelease (SelectionSet fields decoder) =
    FragmentSelectionSet "Release" fields decoder


onReleaseAsset : SelectionSet selection Github.Object.ReleaseAsset -> FragmentSelectionSet selection Github.Object.Node
onReleaseAsset (SelectionSet fields decoder) =
    FragmentSelectionSet "ReleaseAsset" fields decoder


onRemovedFromProjectEvent : SelectionSet selection Github.Object.RemovedFromProjectEvent -> FragmentSelectionSet selection Github.Object.Node
onRemovedFromProjectEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "RemovedFromProjectEvent" fields decoder


onRenamedTitleEvent : SelectionSet selection Github.Object.RenamedTitleEvent -> FragmentSelectionSet selection Github.Object.Node
onRenamedTitleEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "RenamedTitleEvent" fields decoder


onReopenedEvent : SelectionSet selection Github.Object.ReopenedEvent -> FragmentSelectionSet selection Github.Object.Node
onReopenedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReopenedEvent" fields decoder


onRepository : SelectionSet selection Github.Object.Repository -> FragmentSelectionSet selection Github.Object.Node
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


onRepositoryInvitation : SelectionSet selection Github.Object.RepositoryInvitation -> FragmentSelectionSet selection Github.Object.Node
onRepositoryInvitation (SelectionSet fields decoder) =
    FragmentSelectionSet "RepositoryInvitation" fields decoder


onRepositoryTopic : SelectionSet selection Github.Object.RepositoryTopic -> FragmentSelectionSet selection Github.Object.Node
onRepositoryTopic (SelectionSet fields decoder) =
    FragmentSelectionSet "RepositoryTopic" fields decoder


onReviewDismissalAllowance : SelectionSet selection Github.Object.ReviewDismissalAllowance -> FragmentSelectionSet selection Github.Object.Node
onReviewDismissalAllowance (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewDismissalAllowance" fields decoder


onReviewDismissedEvent : SelectionSet selection Github.Object.ReviewDismissedEvent -> FragmentSelectionSet selection Github.Object.Node
onReviewDismissedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewDismissedEvent" fields decoder


onReviewRequest : SelectionSet selection Github.Object.ReviewRequest -> FragmentSelectionSet selection Github.Object.Node
onReviewRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewRequest" fields decoder


onReviewRequestRemovedEvent : SelectionSet selection Github.Object.ReviewRequestRemovedEvent -> FragmentSelectionSet selection Github.Object.Node
onReviewRequestRemovedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewRequestRemovedEvent" fields decoder


onReviewRequestedEvent : SelectionSet selection Github.Object.ReviewRequestedEvent -> FragmentSelectionSet selection Github.Object.Node
onReviewRequestedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "ReviewRequestedEvent" fields decoder


onStatus : SelectionSet selection Github.Object.Status -> FragmentSelectionSet selection Github.Object.Node
onStatus (SelectionSet fields decoder) =
    FragmentSelectionSet "Status" fields decoder


onStatusContext : SelectionSet selection Github.Object.StatusContext -> FragmentSelectionSet selection Github.Object.Node
onStatusContext (SelectionSet fields decoder) =
    FragmentSelectionSet "StatusContext" fields decoder


onSubscribedEvent : SelectionSet selection Github.Object.SubscribedEvent -> FragmentSelectionSet selection Github.Object.Node
onSubscribedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "SubscribedEvent" fields decoder


onTag : SelectionSet selection Github.Object.Tag -> FragmentSelectionSet selection Github.Object.Node
onTag (SelectionSet fields decoder) =
    FragmentSelectionSet "Tag" fields decoder


onTeam : SelectionSet selection Github.Object.Team -> FragmentSelectionSet selection Github.Object.Node
onTeam (SelectionSet fields decoder) =
    FragmentSelectionSet "Team" fields decoder


onTopic : SelectionSet selection Github.Object.Topic -> FragmentSelectionSet selection Github.Object.Node
onTopic (SelectionSet fields decoder) =
    FragmentSelectionSet "Topic" fields decoder


onTree : SelectionSet selection Github.Object.Tree -> FragmentSelectionSet selection Github.Object.Node
onTree (SelectionSet fields decoder) =
    FragmentSelectionSet "Tree" fields decoder


onUnassignedEvent : SelectionSet selection Github.Object.UnassignedEvent -> FragmentSelectionSet selection Github.Object.Node
onUnassignedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "UnassignedEvent" fields decoder


onUnlabeledEvent : SelectionSet selection Github.Object.UnlabeledEvent -> FragmentSelectionSet selection Github.Object.Node
onUnlabeledEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "UnlabeledEvent" fields decoder


onUnlockedEvent : SelectionSet selection Github.Object.UnlockedEvent -> FragmentSelectionSet selection Github.Object.Node
onUnlockedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "UnlockedEvent" fields decoder


onUnsubscribedEvent : SelectionSet selection Github.Object.UnsubscribedEvent -> FragmentSelectionSet selection Github.Object.Node
onUnsubscribedEvent (SelectionSet fields decoder) =
    FragmentSelectionSet "UnsubscribedEvent" fields decoder


onUser : SelectionSet selection Github.Object.User -> FragmentSelectionSet selection Github.Object.Node
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


{-| ID of the object.
-}
id : FieldDecoder String Github.Object.Node
id =
    Object.fieldDecoder "id" [] Decode.string
