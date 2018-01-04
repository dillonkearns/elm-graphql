module Github.Mutation exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Operation exposing (RootMutation)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    Object.object constructor


{-| Applies a suggested topic to the repository.
-}
acceptTopicSuggestion : { input : Value } -> SelectionSet acceptTopicSuggestion Github.Object.AcceptTopicSuggestionPayload -> FieldDecoder (Maybe acceptTopicSuggestion) RootMutation
acceptTopicSuggestion requiredArgs object =
    Object.selectionFieldDecoder "acceptTopicSuggestion" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a comment to an Issue or Pull Request.
-}
addComment : { input : Value } -> SelectionSet addComment Github.Object.AddCommentPayload -> FieldDecoder (Maybe addComment) RootMutation
addComment requiredArgs object =
    Object.selectionFieldDecoder "addComment" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a card to a ProjectColumn. Either `contentId` or `note` must be provided but **not** both.
-}
addProjectCard : { input : Value } -> SelectionSet addProjectCard Github.Object.AddProjectCardPayload -> FieldDecoder (Maybe addProjectCard) RootMutation
addProjectCard requiredArgs object =
    Object.selectionFieldDecoder "addProjectCard" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a column to a Project.
-}
addProjectColumn : { input : Value } -> SelectionSet addProjectColumn Github.Object.AddProjectColumnPayload -> FieldDecoder (Maybe addProjectColumn) RootMutation
addProjectColumn requiredArgs object =
    Object.selectionFieldDecoder "addProjectColumn" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a review to a Pull Request.
-}
addPullRequestReview : { input : Value } -> SelectionSet addPullRequestReview Github.Object.AddPullRequestReviewPayload -> FieldDecoder (Maybe addPullRequestReview) RootMutation
addPullRequestReview requiredArgs object =
    Object.selectionFieldDecoder "addPullRequestReview" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a comment to a review.
-}
addPullRequestReviewComment : { input : Value } -> SelectionSet addPullRequestReviewComment Github.Object.AddPullRequestReviewCommentPayload -> FieldDecoder (Maybe addPullRequestReviewComment) RootMutation
addPullRequestReviewComment requiredArgs object =
    Object.selectionFieldDecoder "addPullRequestReviewComment" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a reaction to a subject.
-}
addReaction : { input : Value } -> SelectionSet addReaction Github.Object.AddReactionPayload -> FieldDecoder (Maybe addReaction) RootMutation
addReaction requiredArgs object =
    Object.selectionFieldDecoder "addReaction" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Adds a star to a Starrable.
-}
addStar : { input : Value } -> SelectionSet addStar Github.Object.AddStarPayload -> FieldDecoder (Maybe addStar) RootMutation
addStar requiredArgs object =
    Object.selectionFieldDecoder "addStar" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Creates a new project.
-}
createProject : { input : Value } -> SelectionSet createProject Github.Object.CreateProjectPayload -> FieldDecoder (Maybe createProject) RootMutation
createProject requiredArgs object =
    Object.selectionFieldDecoder "createProject" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Rejects a suggested topic for the repository.
-}
declineTopicSuggestion : { input : Value } -> SelectionSet declineTopicSuggestion Github.Object.DeclineTopicSuggestionPayload -> FieldDecoder (Maybe declineTopicSuggestion) RootMutation
declineTopicSuggestion requiredArgs object =
    Object.selectionFieldDecoder "declineTopicSuggestion" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Deletes a project.
-}
deleteProject : { input : Value } -> SelectionSet deleteProject Github.Object.DeleteProjectPayload -> FieldDecoder (Maybe deleteProject) RootMutation
deleteProject requiredArgs object =
    Object.selectionFieldDecoder "deleteProject" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Deletes a project card.
-}
deleteProjectCard : { input : Value } -> SelectionSet deleteProjectCard Github.Object.DeleteProjectCardPayload -> FieldDecoder (Maybe deleteProjectCard) RootMutation
deleteProjectCard requiredArgs object =
    Object.selectionFieldDecoder "deleteProjectCard" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Deletes a project column.
-}
deleteProjectColumn : { input : Value } -> SelectionSet deleteProjectColumn Github.Object.DeleteProjectColumnPayload -> FieldDecoder (Maybe deleteProjectColumn) RootMutation
deleteProjectColumn requiredArgs object =
    Object.selectionFieldDecoder "deleteProjectColumn" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Deletes a pull request review.
-}
deletePullRequestReview : { input : Value } -> SelectionSet deletePullRequestReview Github.Object.DeletePullRequestReviewPayload -> FieldDecoder (Maybe deletePullRequestReview) RootMutation
deletePullRequestReview requiredArgs object =
    Object.selectionFieldDecoder "deletePullRequestReview" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Dismisses an approved or rejected pull request review.
-}
dismissPullRequestReview : { input : Value } -> SelectionSet dismissPullRequestReview Github.Object.DismissPullRequestReviewPayload -> FieldDecoder (Maybe dismissPullRequestReview) RootMutation
dismissPullRequestReview requiredArgs object =
    Object.selectionFieldDecoder "dismissPullRequestReview" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Moves a project card to another place.
-}
moveProjectCard : { input : Value } -> SelectionSet moveProjectCard Github.Object.MoveProjectCardPayload -> FieldDecoder (Maybe moveProjectCard) RootMutation
moveProjectCard requiredArgs object =
    Object.selectionFieldDecoder "moveProjectCard" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Moves a project column to another place.
-}
moveProjectColumn : { input : Value } -> SelectionSet moveProjectColumn Github.Object.MoveProjectColumnPayload -> FieldDecoder (Maybe moveProjectColumn) RootMutation
moveProjectColumn requiredArgs object =
    Object.selectionFieldDecoder "moveProjectColumn" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Removes outside collaborator from all repositories in an organization.
-}
removeOutsideCollaborator : { input : Value } -> SelectionSet removeOutsideCollaborator Github.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder (Maybe removeOutsideCollaborator) RootMutation
removeOutsideCollaborator requiredArgs object =
    Object.selectionFieldDecoder "removeOutsideCollaborator" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Removes a reaction from a subject.
-}
removeReaction : { input : Value } -> SelectionSet removeReaction Github.Object.RemoveReactionPayload -> FieldDecoder (Maybe removeReaction) RootMutation
removeReaction requiredArgs object =
    Object.selectionFieldDecoder "removeReaction" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Removes a star from a Starrable.
-}
removeStar : { input : Value } -> SelectionSet removeStar Github.Object.RemoveStarPayload -> FieldDecoder (Maybe removeStar) RootMutation
removeStar requiredArgs object =
    Object.selectionFieldDecoder "removeStar" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Set review requests on a pull request.
-}
requestReviews : { input : Value } -> SelectionSet requestReviews Github.Object.RequestReviewsPayload -> FieldDecoder (Maybe requestReviews) RootMutation
requestReviews requiredArgs object =
    Object.selectionFieldDecoder "requestReviews" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Submits a pending pull request review.
-}
submitPullRequestReview : { input : Value } -> SelectionSet submitPullRequestReview Github.Object.SubmitPullRequestReviewPayload -> FieldDecoder (Maybe submitPullRequestReview) RootMutation
submitPullRequestReview requiredArgs object =
    Object.selectionFieldDecoder "submitPullRequestReview" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates an existing project.
-}
updateProject : { input : Value } -> SelectionSet updateProject Github.Object.UpdateProjectPayload -> FieldDecoder (Maybe updateProject) RootMutation
updateProject requiredArgs object =
    Object.selectionFieldDecoder "updateProject" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates an existing project card.
-}
updateProjectCard : { input : Value } -> SelectionSet updateProjectCard Github.Object.UpdateProjectCardPayload -> FieldDecoder (Maybe updateProjectCard) RootMutation
updateProjectCard requiredArgs object =
    Object.selectionFieldDecoder "updateProjectCard" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates an existing project column.
-}
updateProjectColumn : { input : Value } -> SelectionSet updateProjectColumn Github.Object.UpdateProjectColumnPayload -> FieldDecoder (Maybe updateProjectColumn) RootMutation
updateProjectColumn requiredArgs object =
    Object.selectionFieldDecoder "updateProjectColumn" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates the body of a pull request review.
-}
updatePullRequestReview : { input : Value } -> SelectionSet updatePullRequestReview Github.Object.UpdatePullRequestReviewPayload -> FieldDecoder (Maybe updatePullRequestReview) RootMutation
updatePullRequestReview requiredArgs object =
    Object.selectionFieldDecoder "updatePullRequestReview" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates a pull request review comment.
-}
updatePullRequestReviewComment : { input : Value } -> SelectionSet updatePullRequestReviewComment Github.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder (Maybe updatePullRequestReviewComment) RootMutation
updatePullRequestReviewComment requiredArgs object =
    Object.selectionFieldDecoder "updatePullRequestReviewComment" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Updates viewers repository subscription state.
-}
updateSubscription : { input : Value } -> SelectionSet updateSubscription Github.Object.UpdateSubscriptionPayload -> FieldDecoder (Maybe updateSubscription) RootMutation
updateSubscription requiredArgs object =
    Object.selectionFieldDecoder "updateSubscription" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)


{-| Replaces the repository's topics with the given topics.
-}
updateTopics : { input : Value } -> SelectionSet updateTopics Github.Object.UpdateTopicsPayload -> FieldDecoder (Maybe updateTopics) RootMutation
updateTopics requiredArgs object =
    Object.selectionFieldDecoder "updateTopics" [ Argument.required "input" requiredArgs.input identity ] object (identity >> Decode.maybe)
