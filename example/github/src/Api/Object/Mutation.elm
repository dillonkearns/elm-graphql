module Api.Object.Mutation exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Mutation
build constructor =
    Object.object constructor


acceptTopicSuggestion : ({ input : Maybe String } -> { input : Maybe String }) -> Object acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion Api.Object.Mutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : Maybe String } -> { input : Maybe String }) -> Object addComment Api.Object.AddCommentPayload -> FieldDecoder addComment Api.Object.Mutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addComment" optionalArgs object


addProjectCard : ({ input : Maybe String } -> { input : Maybe String }) -> Object addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard Api.Object.Mutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : Maybe String } -> { input : Maybe String }) -> Object addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn Api.Object.Mutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : Maybe String } -> { input : Maybe String }) -> Object addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview Api.Object.Mutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : Maybe String } -> { input : Maybe String }) -> Object addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment Api.Object.Mutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : Maybe String } -> { input : Maybe String }) -> Object addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction Api.Object.Mutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addReaction" optionalArgs object


addStar : ({ input : Maybe String } -> { input : Maybe String }) -> Object addStar Api.Object.AddStarPayload -> FieldDecoder addStar Api.Object.Mutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "addStar" optionalArgs object


createProject : ({ input : Maybe String } -> { input : Maybe String }) -> Object createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject Api.Object.Mutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : Maybe String } -> { input : Maybe String }) -> Object declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion Api.Object.Mutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : Maybe String } -> { input : Maybe String }) -> Object deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject Api.Object.Mutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : Maybe String } -> { input : Maybe String }) -> Object deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard Api.Object.Mutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : Maybe String } -> { input : Maybe String }) -> Object deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn Api.Object.Mutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : Maybe String } -> { input : Maybe String }) -> Object deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview Api.Object.Mutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : Maybe String } -> { input : Maybe String }) -> Object dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview Api.Object.Mutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : Maybe String } -> { input : Maybe String }) -> Object moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard Api.Object.Mutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : Maybe String } -> { input : Maybe String }) -> Object moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn Api.Object.Mutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : Maybe String } -> { input : Maybe String }) -> Object removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator Api.Object.Mutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : Maybe String } -> { input : Maybe String }) -> Object removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction Api.Object.Mutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "removeReaction" optionalArgs object


removeStar : ({ input : Maybe String } -> { input : Maybe String }) -> Object removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar Api.Object.Mutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "removeStar" optionalArgs object


requestReviews : ({ input : Maybe String } -> { input : Maybe String }) -> Object requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews Api.Object.Mutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : Maybe String } -> { input : Maybe String }) -> Object submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview Api.Object.Mutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : Maybe String } -> { input : Maybe String }) -> Object updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject Api.Object.Mutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updateProject" optionalArgs object


updateProjectCard : ({ input : Maybe String } -> { input : Maybe String }) -> Object updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard Api.Object.Mutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : Maybe String } -> { input : Maybe String }) -> Object updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn Api.Object.Mutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : Maybe String } -> { input : Maybe String }) -> Object updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview Api.Object.Mutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : Maybe String } -> { input : Maybe String }) -> Object updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment Api.Object.Mutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : Maybe String } -> { input : Maybe String }) -> Object updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription Api.Object.Mutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updateSubscription" optionalArgs object


updateTopics : ({ input : Maybe String } -> { input : Maybe String }) -> Object updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics Api.Object.Mutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input Encode.string ]
                |> List.filterMap identity
    in
    Object.single "updateTopics" optionalArgs object
