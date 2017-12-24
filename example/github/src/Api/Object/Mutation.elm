module Api.Object.Mutation exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as SelectionSet exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Json.Decode as Decode
import Json.Encode as Encode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Mutation
selection constructor =
    Object.object constructor


acceptTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion Api.Object.Mutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addComment Api.Object.AddCommentPayload -> FieldDecoder addComment Api.Object.Mutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addComment" optionalArgs object


addProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard Api.Object.Mutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn Api.Object.Mutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview Api.Object.Mutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment Api.Object.Mutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction Api.Object.Mutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addReaction" optionalArgs object


addStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addStar Api.Object.AddStarPayload -> FieldDecoder addStar Api.Object.Mutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addStar" optionalArgs object


createProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject Api.Object.Mutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion Api.Object.Mutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject Api.Object.Mutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard Api.Object.Mutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn Api.Object.Mutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview Api.Object.Mutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview Api.Object.Mutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard Api.Object.Mutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn Api.Object.Mutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator Api.Object.Mutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction Api.Object.Mutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeReaction" optionalArgs object


removeStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar Api.Object.Mutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeStar" optionalArgs object


requestReviews : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews Api.Object.Mutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview Api.Object.Mutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject Api.Object.Mutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProject" optionalArgs object


updateProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard Api.Object.Mutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn Api.Object.Mutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview Api.Object.Mutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment Api.Object.Mutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription Api.Object.Mutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateSubscription" optionalArgs object


updateTopics : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics Api.Object.Mutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateTopics" optionalArgs object
