module Api.Mutation exposing (..)

import Api.Object
import Graphqelm exposing (RootMutation)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    RootObject.object constructor


acceptTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion RootMutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addComment Api.Object.AddCommentPayload -> FieldDecoder addComment RootMutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addComment" optionalArgs object


addProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard RootMutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn RootMutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview RootMutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment RootMutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction RootMutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addReaction" optionalArgs object


addStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet addStar Api.Object.AddStarPayload -> FieldDecoder addStar RootMutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "addStar" optionalArgs object


createProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject RootMutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion RootMutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject RootMutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard RootMutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn RootMutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview RootMutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview RootMutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard RootMutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn RootMutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator RootMutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction RootMutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeReaction" optionalArgs object


removeStar : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar RootMutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "removeStar" optionalArgs object


requestReviews : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews RootMutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview RootMutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject RootMutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProject" optionalArgs object


updateProjectCard : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard RootMutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn RootMutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview RootMutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment RootMutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription RootMutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateSubscription" optionalArgs object


updateTopics : ({ input : Maybe Value } -> { input : Maybe Value }) -> SelectionSet updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics RootMutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Nothing }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    RootObject.single "updateTopics" optionalArgs object
