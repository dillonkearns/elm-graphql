-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Interface.Node exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.ScalarCodecs
import Github.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode


type alias Fragments decodesTo =
    { onAddedToProjectEvent : SelectionSet decodesTo Github.Object.AddedToProjectEvent
    , onAssignedEvent : SelectionSet decodesTo Github.Object.AssignedEvent
    , onBaseRefChangedEvent : SelectionSet decodesTo Github.Object.BaseRefChangedEvent
    , onBaseRefForcePushedEvent : SelectionSet decodesTo Github.Object.BaseRefForcePushedEvent
    , onBlob : SelectionSet decodesTo Github.Object.Blob
    , onBot : SelectionSet decodesTo Github.Object.Bot
    , onClosedEvent : SelectionSet decodesTo Github.Object.ClosedEvent
    , onCommentDeletedEvent : SelectionSet decodesTo Github.Object.CommentDeletedEvent
    , onCommit : SelectionSet decodesTo Github.Object.Commit
    , onCommitComment : SelectionSet decodesTo Github.Object.CommitComment
    , onCommitCommentThread : SelectionSet decodesTo Github.Object.CommitCommentThread
    , onConvertedNoteToIssueEvent : SelectionSet decodesTo Github.Object.ConvertedNoteToIssueEvent
    , onCrossReferencedEvent : SelectionSet decodesTo Github.Object.CrossReferencedEvent
    , onDemilestonedEvent : SelectionSet decodesTo Github.Object.DemilestonedEvent
    , onDeployKey : SelectionSet decodesTo Github.Object.DeployKey
    , onDeployedEvent : SelectionSet decodesTo Github.Object.DeployedEvent
    , onDeployment : SelectionSet decodesTo Github.Object.Deployment
    , onDeploymentStatus : SelectionSet decodesTo Github.Object.DeploymentStatus
    , onExternalIdentity : SelectionSet decodesTo Github.Object.ExternalIdentity
    , onGist : SelectionSet decodesTo Github.Object.Gist
    , onGistComment : SelectionSet decodesTo Github.Object.GistComment
    , onHeadRefDeletedEvent : SelectionSet decodesTo Github.Object.HeadRefDeletedEvent
    , onHeadRefForcePushedEvent : SelectionSet decodesTo Github.Object.HeadRefForcePushedEvent
    , onHeadRefRestoredEvent : SelectionSet decodesTo Github.Object.HeadRefRestoredEvent
    , onIssue : SelectionSet decodesTo Github.Object.Issue
    , onIssueComment : SelectionSet decodesTo Github.Object.IssueComment
    , onLabel : SelectionSet decodesTo Github.Object.Label
    , onLabeledEvent : SelectionSet decodesTo Github.Object.LabeledEvent
    , onLanguage : SelectionSet decodesTo Github.Object.Language
    , onLockedEvent : SelectionSet decodesTo Github.Object.LockedEvent
    , onMarketplaceListing : SelectionSet decodesTo Github.Object.MarketplaceListing
    , onMentionedEvent : SelectionSet decodesTo Github.Object.MentionedEvent
    , onMergedEvent : SelectionSet decodesTo Github.Object.MergedEvent
    , onMilestone : SelectionSet decodesTo Github.Object.Milestone
    , onMilestonedEvent : SelectionSet decodesTo Github.Object.MilestonedEvent
    , onMovedColumnsInProjectEvent : SelectionSet decodesTo Github.Object.MovedColumnsInProjectEvent
    , onOrganization : SelectionSet decodesTo Github.Object.Organization
    , onOrganizationIdentityProvider : SelectionSet decodesTo Github.Object.OrganizationIdentityProvider
    , onOrganizationInvitation : SelectionSet decodesTo Github.Object.OrganizationInvitation
    , onProject : SelectionSet decodesTo Github.Object.Project
    , onProjectCard : SelectionSet decodesTo Github.Object.ProjectCard
    , onProjectColumn : SelectionSet decodesTo Github.Object.ProjectColumn
    , onProtectedBranch : SelectionSet decodesTo Github.Object.ProtectedBranch
    , onPublicKey : SelectionSet decodesTo Github.Object.PublicKey
    , onPullRequest : SelectionSet decodesTo Github.Object.PullRequest
    , onPullRequestCommit : SelectionSet decodesTo Github.Object.PullRequestCommit
    , onPullRequestReview : SelectionSet decodesTo Github.Object.PullRequestReview
    , onPullRequestReviewComment : SelectionSet decodesTo Github.Object.PullRequestReviewComment
    , onPullRequestReviewThread : SelectionSet decodesTo Github.Object.PullRequestReviewThread
    , onPushAllowance : SelectionSet decodesTo Github.Object.PushAllowance
    , onReaction : SelectionSet decodesTo Github.Object.Reaction
    , onRef : SelectionSet decodesTo Github.Object.Ref
    , onReferencedEvent : SelectionSet decodesTo Github.Object.ReferencedEvent
    , onRelease : SelectionSet decodesTo Github.Object.Release
    , onReleaseAsset : SelectionSet decodesTo Github.Object.ReleaseAsset
    , onRemovedFromProjectEvent : SelectionSet decodesTo Github.Object.RemovedFromProjectEvent
    , onRenamedTitleEvent : SelectionSet decodesTo Github.Object.RenamedTitleEvent
    , onReopenedEvent : SelectionSet decodesTo Github.Object.ReopenedEvent
    , onRepository : SelectionSet decodesTo Github.Object.Repository
    , onRepositoryInvitation : SelectionSet decodesTo Github.Object.RepositoryInvitation
    , onRepositoryTopic : SelectionSet decodesTo Github.Object.RepositoryTopic
    , onReviewDismissalAllowance : SelectionSet decodesTo Github.Object.ReviewDismissalAllowance
    , onReviewDismissedEvent : SelectionSet decodesTo Github.Object.ReviewDismissedEvent
    , onReviewRequest : SelectionSet decodesTo Github.Object.ReviewRequest
    , onReviewRequestRemovedEvent : SelectionSet decodesTo Github.Object.ReviewRequestRemovedEvent
    , onReviewRequestedEvent : SelectionSet decodesTo Github.Object.ReviewRequestedEvent
    , onStatus : SelectionSet decodesTo Github.Object.Status
    , onStatusContext : SelectionSet decodesTo Github.Object.StatusContext
    , onSubscribedEvent : SelectionSet decodesTo Github.Object.SubscribedEvent
    , onTag : SelectionSet decodesTo Github.Object.Tag
    , onTeam : SelectionSet decodesTo Github.Object.Team
    , onTopic : SelectionSet decodesTo Github.Object.Topic
    , onTree : SelectionSet decodesTo Github.Object.Tree
    , onUnassignedEvent : SelectionSet decodesTo Github.Object.UnassignedEvent
    , onUnlabeledEvent : SelectionSet decodesTo Github.Object.UnlabeledEvent
    , onUnlockedEvent : SelectionSet decodesTo Github.Object.UnlockedEvent
    , onUnsubscribedEvent : SelectionSet decodesTo Github.Object.UnsubscribedEvent
    , onUser : SelectionSet decodesTo Github.Object.User
    , onUserContentEdit : SelectionSet decodesTo Github.Object.UserContentEdit
    }


{-| Build an exhaustive selection of type-specific fragments.
-}
fragments :
    Fragments decodesTo
    -> SelectionSet decodesTo Github.Interface.Node
fragments selections____ =
    Object.exhaustiveFragmentSelection
        [ Object.buildFragment "AddedToProjectEvent" selections____.onAddedToProjectEvent
        , Object.buildFragment "AssignedEvent" selections____.onAssignedEvent
        , Object.buildFragment "BaseRefChangedEvent" selections____.onBaseRefChangedEvent
        , Object.buildFragment "BaseRefForcePushedEvent" selections____.onBaseRefForcePushedEvent
        , Object.buildFragment "Blob" selections____.onBlob
        , Object.buildFragment "Bot" selections____.onBot
        , Object.buildFragment "ClosedEvent" selections____.onClosedEvent
        , Object.buildFragment "CommentDeletedEvent" selections____.onCommentDeletedEvent
        , Object.buildFragment "Commit" selections____.onCommit
        , Object.buildFragment "CommitComment" selections____.onCommitComment
        , Object.buildFragment "CommitCommentThread" selections____.onCommitCommentThread
        , Object.buildFragment "ConvertedNoteToIssueEvent" selections____.onConvertedNoteToIssueEvent
        , Object.buildFragment "CrossReferencedEvent" selections____.onCrossReferencedEvent
        , Object.buildFragment "DemilestonedEvent" selections____.onDemilestonedEvent
        , Object.buildFragment "DeployKey" selections____.onDeployKey
        , Object.buildFragment "DeployedEvent" selections____.onDeployedEvent
        , Object.buildFragment "Deployment" selections____.onDeployment
        , Object.buildFragment "DeploymentStatus" selections____.onDeploymentStatus
        , Object.buildFragment "ExternalIdentity" selections____.onExternalIdentity
        , Object.buildFragment "Gist" selections____.onGist
        , Object.buildFragment "GistComment" selections____.onGistComment
        , Object.buildFragment "HeadRefDeletedEvent" selections____.onHeadRefDeletedEvent
        , Object.buildFragment "HeadRefForcePushedEvent" selections____.onHeadRefForcePushedEvent
        , Object.buildFragment "HeadRefRestoredEvent" selections____.onHeadRefRestoredEvent
        , Object.buildFragment "Issue" selections____.onIssue
        , Object.buildFragment "IssueComment" selections____.onIssueComment
        , Object.buildFragment "Label" selections____.onLabel
        , Object.buildFragment "LabeledEvent" selections____.onLabeledEvent
        , Object.buildFragment "Language" selections____.onLanguage
        , Object.buildFragment "LockedEvent" selections____.onLockedEvent
        , Object.buildFragment "MarketplaceListing" selections____.onMarketplaceListing
        , Object.buildFragment "MentionedEvent" selections____.onMentionedEvent
        , Object.buildFragment "MergedEvent" selections____.onMergedEvent
        , Object.buildFragment "Milestone" selections____.onMilestone
        , Object.buildFragment "MilestonedEvent" selections____.onMilestonedEvent
        , Object.buildFragment "MovedColumnsInProjectEvent" selections____.onMovedColumnsInProjectEvent
        , Object.buildFragment "Organization" selections____.onOrganization
        , Object.buildFragment "OrganizationIdentityProvider" selections____.onOrganizationIdentityProvider
        , Object.buildFragment "OrganizationInvitation" selections____.onOrganizationInvitation
        , Object.buildFragment "Project" selections____.onProject
        , Object.buildFragment "ProjectCard" selections____.onProjectCard
        , Object.buildFragment "ProjectColumn" selections____.onProjectColumn
        , Object.buildFragment "ProtectedBranch" selections____.onProtectedBranch
        , Object.buildFragment "PublicKey" selections____.onPublicKey
        , Object.buildFragment "PullRequest" selections____.onPullRequest
        , Object.buildFragment "PullRequestCommit" selections____.onPullRequestCommit
        , Object.buildFragment "PullRequestReview" selections____.onPullRequestReview
        , Object.buildFragment "PullRequestReviewComment" selections____.onPullRequestReviewComment
        , Object.buildFragment "PullRequestReviewThread" selections____.onPullRequestReviewThread
        , Object.buildFragment "PushAllowance" selections____.onPushAllowance
        , Object.buildFragment "Reaction" selections____.onReaction
        , Object.buildFragment "Ref" selections____.onRef
        , Object.buildFragment "ReferencedEvent" selections____.onReferencedEvent
        , Object.buildFragment "Release" selections____.onRelease
        , Object.buildFragment "ReleaseAsset" selections____.onReleaseAsset
        , Object.buildFragment "RemovedFromProjectEvent" selections____.onRemovedFromProjectEvent
        , Object.buildFragment "RenamedTitleEvent" selections____.onRenamedTitleEvent
        , Object.buildFragment "ReopenedEvent" selections____.onReopenedEvent
        , Object.buildFragment "Repository" selections____.onRepository
        , Object.buildFragment "RepositoryInvitation" selections____.onRepositoryInvitation
        , Object.buildFragment "RepositoryTopic" selections____.onRepositoryTopic
        , Object.buildFragment "ReviewDismissalAllowance" selections____.onReviewDismissalAllowance
        , Object.buildFragment "ReviewDismissedEvent" selections____.onReviewDismissedEvent
        , Object.buildFragment "ReviewRequest" selections____.onReviewRequest
        , Object.buildFragment "ReviewRequestRemovedEvent" selections____.onReviewRequestRemovedEvent
        , Object.buildFragment "ReviewRequestedEvent" selections____.onReviewRequestedEvent
        , Object.buildFragment "Status" selections____.onStatus
        , Object.buildFragment "StatusContext" selections____.onStatusContext
        , Object.buildFragment "SubscribedEvent" selections____.onSubscribedEvent
        , Object.buildFragment "Tag" selections____.onTag
        , Object.buildFragment "Team" selections____.onTeam
        , Object.buildFragment "Topic" selections____.onTopic
        , Object.buildFragment "Tree" selections____.onTree
        , Object.buildFragment "UnassignedEvent" selections____.onUnassignedEvent
        , Object.buildFragment "UnlabeledEvent" selections____.onUnlabeledEvent
        , Object.buildFragment "UnlockedEvent" selections____.onUnlockedEvent
        , Object.buildFragment "UnsubscribedEvent" selections____.onUnsubscribedEvent
        , Object.buildFragment "User" selections____.onUser
        , Object.buildFragment "UserContentEdit" selections____.onUserContentEdit
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    { onAddedToProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onAssignedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBaseRefChangedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBaseRefForcePushedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBlob = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onBot = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onClosedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCommentDeletedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCommit = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCommitComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCommitCommentThread = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onConvertedNoteToIssueEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onCrossReferencedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDemilestonedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeployKey = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeployedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeployment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onDeploymentStatus = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onExternalIdentity = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onGist = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onGistComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefDeletedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefForcePushedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onHeadRefRestoredEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onIssue = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onIssueComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLabel = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLabeledEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLanguage = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onLockedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMarketplaceListing = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMentionedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMergedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMilestone = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMilestonedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onMovedColumnsInProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onOrganization = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onOrganizationIdentityProvider = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onOrganizationInvitation = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onProject = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onProjectCard = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onProjectColumn = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onProtectedBranch = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPublicKey = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequest = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestCommit = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestReview = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestReviewComment = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPullRequestReviewThread = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onPushAllowance = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReaction = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRef = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReferencedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRelease = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReleaseAsset = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRemovedFromProjectEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRenamedTitleEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReopenedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRepository = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRepositoryInvitation = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onRepositoryTopic = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewDismissalAllowance = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewDismissedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewRequest = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewRequestRemovedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onReviewRequestedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onStatus = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onStatusContext = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onSubscribedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onTag = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onTeam = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onTopic = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onTree = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnassignedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnlabeledEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnlockedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUnsubscribedEvent = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUser = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    , onUserContentEdit = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }


{-| ID of the object.
-}
id : SelectionSet Github.ScalarCodecs.Id Github.Interface.Node
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecId |> .decoder)
