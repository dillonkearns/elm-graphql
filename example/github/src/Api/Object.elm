module Api.Object exposing (..)


type Node
    = Node


type UniformResourceLocatable
    = UniformResourceLocatable


type User
    = User


type Actor
    = Actor


type Repository
    = Repository


type ProjectOwner
    = ProjectOwner


type Project
    = Project


type Closable
    = Closable


type Updatable
    = Updatable


type ProjectColumnConnection
    = ProjectColumnConnection


type ProjectColumnEdge
    = ProjectColumnEdge


type ProjectColumn
    = ProjectColumn


type ProjectCardConnection
    = ProjectCardConnection


type ProjectCardEdge
    = ProjectCardEdge


type ProjectCard
    = ProjectCard


type Issue
    = Issue


type Assignable
    = Assignable


type UserConnection
    = UserConnection


type UserEdge
    = UserEdge


type PageInfo
    = PageInfo


type Comment
    = Comment


type UserContentEditEdge
    = UserContentEditEdge


type UserContentEdit
    = UserContentEdit


type UpdatableComment
    = UpdatableComment


type Labelable
    = Labelable


type LabelConnection
    = LabelConnection


type LabelEdge
    = LabelEdge


type Label
    = Label


type IssueConnection
    = IssueConnection


type IssueEdge
    = IssueEdge


type PullRequestConnection
    = PullRequestConnection


type PullRequestEdge
    = PullRequestEdge


type PullRequest
    = PullRequest


type Lockable
    = Lockable


type Reactable
    = Reactable


type ReactionGroup
    = ReactionGroup


type ReactingUserConnection
    = ReactingUserConnection


type ReactingUserEdge
    = ReactingUserEdge


type ReactionConnection
    = ReactionConnection


type ReactionEdge
    = ReactionEdge


type Reaction
    = Reaction


type RepositoryNode
    = RepositoryNode


type Subscribable
    = Subscribable


type Ref
    = Ref


type GitObject
    = GitObject


type Commit
    = Commit


type Tree
    = Tree


type TreeEntry
    = TreeEntry


type GitActor
    = GitActor


type CommitConnection
    = CommitConnection


type CommitEdge
    = CommitEdge


type CommitHistoryConnection
    = CommitHistoryConnection


type CommitCommentConnection
    = CommitCommentConnection


type CommitCommentEdge
    = CommitCommentEdge


type CommitComment
    = CommitComment


type Deletable
    = Deletable


type GitSignature
    = GitSignature


type Status
    = Status


type StatusContext
    = StatusContext


type Blame
    = Blame


type BlameRange
    = BlameRange


type Blob
    = Blob


type Language
    = Language


type RepositoryOwner
    = RepositoryOwner


type RepositoryConnection
    = RepositoryConnection


type RepositoryEdge
    = RepositoryEdge


type Milestone
    = Milestone


type IssueCommentConnection
    = IssueCommentConnection


type IssueCommentEdge
    = IssueCommentEdge


type IssueComment
    = IssueComment


type PullRequestReviewConnection
    = PullRequestReviewConnection


type PullRequestReviewEdge
    = PullRequestReviewEdge


type PullRequestReview
    = PullRequestReview


type PullRequestReviewCommentConnection
    = PullRequestReviewCommentConnection


type PullRequestReviewCommentEdge
    = PullRequestReviewCommentEdge


type PullRequestReviewComment
    = PullRequestReviewComment


type TeamConnection
    = TeamConnection


type TeamEdge
    = TeamEdge


type Team
    = Team


type TeamMemberConnection
    = TeamMemberConnection


type TeamMemberEdge
    = TeamMemberEdge


type TeamRepositoryConnection
    = TeamRepositoryConnection


type TeamRepositoryEdge
    = TeamRepositoryEdge


type OrganizationInvitationConnection
    = OrganizationInvitationConnection


type OrganizationInvitationEdge
    = OrganizationInvitationEdge


type OrganizationInvitation
    = OrganizationInvitation


type Organization
    = Organization


type MarketplaceListing
    = MarketplaceListing


type OrganizationConnection
    = OrganizationConnection


type OrganizationEdge
    = OrganizationEdge


type Bot
    = Bot


type MarketplaceCategory
    = MarketplaceCategory


type LanguageConnection
    = LanguageConnection


type LanguageEdge
    = LanguageEdge


type ProjectConnection
    = ProjectConnection


type ProjectEdge
    = ProjectEdge


type OrganizationIdentityProvider
    = OrganizationIdentityProvider


type ExternalIdentityConnection
    = ExternalIdentityConnection


type ExternalIdentityEdge
    = ExternalIdentityEdge


type ExternalIdentity
    = ExternalIdentity


type ExternalIdentitySamlAttributes
    = ExternalIdentitySamlAttributes


type ExternalIdentityScimAttributes
    = ExternalIdentityScimAttributes


type GistConnection
    = GistConnection


type GistEdge
    = GistEdge


type Gist
    = Gist


type Starrable
    = Starrable


type StargazerConnection
    = StargazerConnection


type StargazerEdge
    = StargazerEdge


type GistCommentConnection
    = GistCommentConnection


type GistCommentEdge
    = GistCommentEdge


type GistComment
    = GistComment


type PullRequestReviewThread
    = PullRequestReviewThread


type PullRequestCommitConnection
    = PullRequestCommitConnection


type PullRequestCommitEdge
    = PullRequestCommitEdge


type PullRequestCommit
    = PullRequestCommit


type ReviewRequestConnection
    = ReviewRequestConnection


type ReviewRequestEdge
    = ReviewRequestEdge


type ReviewRequest
    = ReviewRequest


type PullRequestTimelineConnection
    = PullRequestTimelineConnection


type PullRequestTimelineItemEdge
    = PullRequestTimelineItemEdge


type CommitCommentThread
    = CommitCommentThread


type ClosedEvent
    = ClosedEvent


type ReopenedEvent
    = ReopenedEvent


type SubscribedEvent
    = SubscribedEvent


type UnsubscribedEvent
    = UnsubscribedEvent


type MergedEvent
    = MergedEvent


type ReferencedEvent
    = ReferencedEvent


type CrossReferencedEvent
    = CrossReferencedEvent


type AssignedEvent
    = AssignedEvent


type UnassignedEvent
    = UnassignedEvent


type LabeledEvent
    = LabeledEvent


type UnlabeledEvent
    = UnlabeledEvent


type MilestonedEvent
    = MilestonedEvent


type DemilestonedEvent
    = DemilestonedEvent


type RenamedTitleEvent
    = RenamedTitleEvent


type LockedEvent
    = LockedEvent


type UnlockedEvent
    = UnlockedEvent


type DeployedEvent
    = DeployedEvent


type Deployment
    = Deployment


type DeploymentStatusConnection
    = DeploymentStatusConnection


type DeploymentStatusEdge
    = DeploymentStatusEdge


type DeploymentStatus
    = DeploymentStatus


type HeadRefDeletedEvent
    = HeadRefDeletedEvent


type HeadRefRestoredEvent
    = HeadRefRestoredEvent


type HeadRefForcePushedEvent
    = HeadRefForcePushedEvent


type BaseRefForcePushedEvent
    = BaseRefForcePushedEvent


type ReviewRequestedEvent
    = ReviewRequestedEvent


type ReviewRequestRemovedEvent
    = ReviewRequestRemovedEvent


type ReviewDismissedEvent
    = ReviewDismissedEvent


type BaseRefChangedEvent
    = BaseRefChangedEvent


type AddedToProjectEvent
    = AddedToProjectEvent


type CommentDeletedEvent
    = CommentDeletedEvent


type ConvertedNoteToIssueEvent
    = ConvertedNoteToIssueEvent


type MentionedEvent
    = MentionedEvent


type MovedColumnsInProjectEvent
    = MovedColumnsInProjectEvent


type RemovedFromProjectEvent
    = RemovedFromProjectEvent


type SuggestedReviewer
    = SuggestedReviewer


type IssueTimelineConnection
    = IssueTimelineConnection


type IssueTimelineItemEdge
    = IssueTimelineItemEdge


type RepositoryInfo
    = RepositoryInfo


type License
    = License


type LicenseRule
    = LicenseRule


type RepositoryTopicConnection
    = RepositoryTopicConnection


type RepositoryTopicEdge
    = RepositoryTopicEdge


type RepositoryTopic
    = RepositoryTopic


type Topic
    = Topic


type Release
    = Release


type ReleaseAssetConnection
    = ReleaseAssetConnection


type ReleaseAssetEdge
    = ReleaseAssetEdge


type ReleaseAsset
    = ReleaseAsset


type ProtectedBranchConnection
    = ProtectedBranchConnection


type ProtectedBranchEdge
    = ProtectedBranchEdge


type ProtectedBranch
    = ProtectedBranch


type ReviewDismissalAllowanceConnection
    = ReviewDismissalAllowanceConnection


type ReviewDismissalAllowanceEdge
    = ReviewDismissalAllowanceEdge


type ReviewDismissalAllowance
    = ReviewDismissalAllowance


type PushAllowanceConnection
    = PushAllowanceConnection


type PushAllowanceEdge
    = PushAllowanceEdge


type PushAllowance
    = PushAllowance


type MilestoneConnection
    = MilestoneConnection


type MilestoneEdge
    = MilestoneEdge


type CodeOfConduct
    = CodeOfConduct


type RepositoryCollaboratorConnection
    = RepositoryCollaboratorConnection


type RepositoryCollaboratorEdge
    = RepositoryCollaboratorEdge


type RefConnection
    = RefConnection


type RefEdge
    = RefEdge


type ReleaseConnection
    = ReleaseConnection


type ReleaseEdge
    = ReleaseEdge


type DeploymentConnection
    = DeploymentConnection


type DeploymentEdge
    = DeploymentEdge


type TopicConnection
    = TopicConnection


type TopicEdge
    = TopicEdge


type PublicKeyConnection
    = PublicKeyConnection


type PublicKeyEdge
    = PublicKeyEdge


type PublicKey
    = PublicKey


type FollowingConnection
    = FollowingConnection


type FollowerConnection
    = FollowerConnection


type StarredRepositoryConnection
    = StarredRepositoryConnection


type StarredRepositoryEdge
    = StarredRepositoryEdge


type RateLimit
    = RateLimit


type SearchResultItemConnection
    = SearchResultItemConnection


type SearchResultItemEdge
    = SearchResultItemEdge


type MarketplaceListingConnection
    = MarketplaceListingConnection


type MarketplaceListingEdge
    = MarketplaceListingEdge


type GitHubMetadata
    = GitHubMetadata


type Mutation
    = Mutation


type AddReactionPayload
    = AddReactionPayload


type RemoveReactionPayload
    = RemoveReactionPayload


type UpdateSubscriptionPayload
    = UpdateSubscriptionPayload


type AddCommentPayload
    = AddCommentPayload


type CreateProjectPayload
    = CreateProjectPayload


type UpdateProjectPayload
    = UpdateProjectPayload


type DeleteProjectPayload
    = DeleteProjectPayload


type AddProjectColumnPayload
    = AddProjectColumnPayload


type MoveProjectColumnPayload
    = MoveProjectColumnPayload


type UpdateProjectColumnPayload
    = UpdateProjectColumnPayload


type DeleteProjectColumnPayload
    = DeleteProjectColumnPayload


type AddProjectCardPayload
    = AddProjectCardPayload


type UpdateProjectCardPayload
    = UpdateProjectCardPayload


type MoveProjectCardPayload
    = MoveProjectCardPayload


type DeleteProjectCardPayload
    = DeleteProjectCardPayload


type AddPullRequestReviewPayload
    = AddPullRequestReviewPayload


type SubmitPullRequestReviewPayload
    = SubmitPullRequestReviewPayload


type UpdatePullRequestReviewPayload
    = UpdatePullRequestReviewPayload


type DismissPullRequestReviewPayload
    = DismissPullRequestReviewPayload


type DeletePullRequestReviewPayload
    = DeletePullRequestReviewPayload


type AddPullRequestReviewCommentPayload
    = AddPullRequestReviewCommentPayload


type UpdatePullRequestReviewCommentPayload
    = UpdatePullRequestReviewCommentPayload


type RemoveOutsideCollaboratorPayload
    = RemoveOutsideCollaboratorPayload


type RequestReviewsPayload
    = RequestReviewsPayload


type AddStarPayload
    = AddStarPayload


type RemoveStarPayload
    = RemoveStarPayload


type AcceptTopicSuggestionPayload
    = AcceptTopicSuggestionPayload


type DeclineTopicSuggestionPayload
    = DeclineTopicSuggestionPayload


type UpdateTopicsPayload
    = UpdateTopicsPayload


type GpgSignature
    = GpgSignature


type RepositoryInvitation
    = RepositoryInvitation


type RepositoryInvitationRepository
    = RepositoryInvitationRepository


type SmimeSignature
    = SmimeSignature


type Tag
    = Tag


type UnknownSignature
    = UnknownSignature
