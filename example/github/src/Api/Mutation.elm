module Api.Mutation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Document exposing (DocumentRoot)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Mutation as Mutation
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


acceptTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> DocumentRoot acceptTopicSuggestion
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addComment Api.Object.AddCommentPayload -> DocumentRoot addComment
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addComment" optionalArgs object


addProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addProjectCard Api.Object.AddProjectCardPayload -> DocumentRoot addProjectCard
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addProjectColumn Api.Object.AddProjectColumnPayload -> DocumentRoot addProjectColumn
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addPullRequestReview Api.Object.AddPullRequestReviewPayload -> DocumentRoot addPullRequestReview
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> DocumentRoot addPullRequestReviewComment
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addReaction Api.Object.AddReactionPayload -> DocumentRoot addReaction
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addReaction" optionalArgs object


addStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addStar Api.Object.AddStarPayload -> DocumentRoot addStar
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "addStar" optionalArgs object


createProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object createProject Api.Object.CreateProjectPayload -> DocumentRoot createProject
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> DocumentRoot declineTopicSuggestion
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProject Api.Object.DeleteProjectPayload -> DocumentRoot deleteProject
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProjectCard Api.Object.DeleteProjectCardPayload -> DocumentRoot deleteProjectCard
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> DocumentRoot deleteProjectColumn
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> DocumentRoot deletePullRequestReview
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> DocumentRoot dismissPullRequestReview
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object moveProjectCard Api.Object.MoveProjectCardPayload -> DocumentRoot moveProjectCard
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object moveProjectColumn Api.Object.MoveProjectColumnPayload -> DocumentRoot moveProjectColumn
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> DocumentRoot removeOutsideCollaborator
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeReaction Api.Object.RemoveReactionPayload -> DocumentRoot removeReaction
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "removeReaction" optionalArgs object


removeStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeStar Api.Object.RemoveStarPayload -> DocumentRoot removeStar
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "removeStar" optionalArgs object


requestReviews : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object requestReviews Api.Object.RequestReviewsPayload -> DocumentRoot requestReviews
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> DocumentRoot submitPullRequestReview
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProject Api.Object.UpdateProjectPayload -> DocumentRoot updateProject
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updateProject" optionalArgs object


updateProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProjectCard Api.Object.UpdateProjectCardPayload -> DocumentRoot updateProjectCard
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProjectColumn Api.Object.UpdateProjectColumnPayload -> DocumentRoot updateProjectColumn
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> DocumentRoot updatePullRequestReview
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> DocumentRoot updatePullRequestReviewComment
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateSubscription Api.Object.UpdateSubscriptionPayload -> DocumentRoot updateSubscription
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updateSubscription" optionalArgs object


updateTopics : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateTopics Api.Object.UpdateTopicsPayload -> DocumentRoot updateTopics
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Mutation.single "updateTopics" optionalArgs object
