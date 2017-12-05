module Api.Object.Mutation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Mutation
build constructor =
    Object.object constructor


acceptTopicSuggestion : Object acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion Api.Object.Mutation
acceptTopicSuggestion object =
    Object.single "acceptTopicSuggestion" [] object


addComment : Object addComment Api.Object.AddCommentPayload -> FieldDecoder addComment Api.Object.Mutation
addComment object =
    Object.single "addComment" [] object


addProjectCard : Object addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard Api.Object.Mutation
addProjectCard object =
    Object.single "addProjectCard" [] object


addProjectColumn : Object addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn Api.Object.Mutation
addProjectColumn object =
    Object.single "addProjectColumn" [] object


addPullRequestReview : Object addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview Api.Object.Mutation
addPullRequestReview object =
    Object.single "addPullRequestReview" [] object


addPullRequestReviewComment : Object addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment Api.Object.Mutation
addPullRequestReviewComment object =
    Object.single "addPullRequestReviewComment" [] object


addReaction : Object addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction Api.Object.Mutation
addReaction object =
    Object.single "addReaction" [] object


addStar : Object addStar Api.Object.AddStarPayload -> FieldDecoder addStar Api.Object.Mutation
addStar object =
    Object.single "addStar" [] object


createProject : Object createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject Api.Object.Mutation
createProject object =
    Object.single "createProject" [] object


declineTopicSuggestion : Object declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion Api.Object.Mutation
declineTopicSuggestion object =
    Object.single "declineTopicSuggestion" [] object


deleteProject : Object deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject Api.Object.Mutation
deleteProject object =
    Object.single "deleteProject" [] object


deleteProjectCard : Object deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard Api.Object.Mutation
deleteProjectCard object =
    Object.single "deleteProjectCard" [] object


deleteProjectColumn : Object deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn Api.Object.Mutation
deleteProjectColumn object =
    Object.single "deleteProjectColumn" [] object


deletePullRequestReview : Object deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview Api.Object.Mutation
deletePullRequestReview object =
    Object.single "deletePullRequestReview" [] object


dismissPullRequestReview : Object dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview Api.Object.Mutation
dismissPullRequestReview object =
    Object.single "dismissPullRequestReview" [] object


moveProjectCard : Object moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard Api.Object.Mutation
moveProjectCard object =
    Object.single "moveProjectCard" [] object


moveProjectColumn : Object moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn Api.Object.Mutation
moveProjectColumn object =
    Object.single "moveProjectColumn" [] object


removeOutsideCollaborator : Object removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator Api.Object.Mutation
removeOutsideCollaborator object =
    Object.single "removeOutsideCollaborator" [] object


removeReaction : Object removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction Api.Object.Mutation
removeReaction object =
    Object.single "removeReaction" [] object


removeStar : Object removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar Api.Object.Mutation
removeStar object =
    Object.single "removeStar" [] object


requestReviews : Object requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews Api.Object.Mutation
requestReviews object =
    Object.single "requestReviews" [] object


submitPullRequestReview : Object submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview Api.Object.Mutation
submitPullRequestReview object =
    Object.single "submitPullRequestReview" [] object


updateProject : Object updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject Api.Object.Mutation
updateProject object =
    Object.single "updateProject" [] object


updateProjectCard : Object updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard Api.Object.Mutation
updateProjectCard object =
    Object.single "updateProjectCard" [] object


updateProjectColumn : Object updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn Api.Object.Mutation
updateProjectColumn object =
    Object.single "updateProjectColumn" [] object


updatePullRequestReview : Object updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview Api.Object.Mutation
updatePullRequestReview object =
    Object.single "updatePullRequestReview" [] object


updatePullRequestReviewComment : Object updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment Api.Object.Mutation
updatePullRequestReviewComment object =
    Object.single "updatePullRequestReviewComment" [] object


updateSubscription : Object updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription Api.Object.Mutation
updateSubscription object =
    Object.single "updateSubscription" [] object


updateTopics : Object updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics Api.Object.Mutation
updateTopics object =
    Object.single "updateTopics" [] object
