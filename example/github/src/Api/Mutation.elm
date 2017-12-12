module Api.Mutation exposing (..)

import Api.Object
import Graphqelm exposing (RootMutation)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode exposing (Decoder)


build : (a -> constructor) -> Object (a -> constructor) RootMutation
build constructor =
    RootObject.object constructor


acceptTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion RootMutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addComment Api.Object.AddCommentPayload -> FieldDecoder addComment RootMutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addComment" optionalArgs object


addProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard RootMutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn RootMutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview RootMutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment RootMutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction RootMutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addReaction" optionalArgs object


addStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object addStar Api.Object.AddStarPayload -> FieldDecoder addStar RootMutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addStar" optionalArgs object


createProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject RootMutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion RootMutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject RootMutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard RootMutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn RootMutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview RootMutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview RootMutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard RootMutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn RootMutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator RootMutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction RootMutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeReaction" optionalArgs object


removeStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar RootMutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeStar" optionalArgs object


requestReviews : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews RootMutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview RootMutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject RootMutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProject" optionalArgs object


updateProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard RootMutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn RootMutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview RootMutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment RootMutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription RootMutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateSubscription" optionalArgs object


updateTopics : ({ input : Maybe Value } -> { input : Maybe Value }) -> Object updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics RootMutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateTopics" optionalArgs object
