module Api.Mutation exposing (..)

import Api.Object
import Graphqelm exposing (RootMutation)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootMutation
selection constructor =
    Object.object constructor


acceptTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet acceptTopicSuggestion Api.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion RootMutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "acceptTopicSuggestion" optionalArgs object


addComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addComment Api.Object.AddCommentPayload -> FieldDecoder addComment RootMutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addComment" optionalArgs object


addProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectCard Api.Object.AddProjectCardPayload -> FieldDecoder addProjectCard RootMutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addProjectCard" optionalArgs object


addProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectColumn Api.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn RootMutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addProjectColumn" optionalArgs object


addPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReview Api.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview RootMutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReview" optionalArgs object


addPullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReviewComment Api.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment RootMutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addPullRequestReviewComment" optionalArgs object


addReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addReaction Api.Object.AddReactionPayload -> FieldDecoder addReaction RootMutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addReaction" optionalArgs object


addStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addStar Api.Object.AddStarPayload -> FieldDecoder addStar RootMutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "addStar" optionalArgs object


createProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet createProject Api.Object.CreateProjectPayload -> FieldDecoder createProject RootMutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "createProject" optionalArgs object


declineTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet declineTopicSuggestion Api.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion RootMutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "declineTopicSuggestion" optionalArgs object


deleteProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProject Api.Object.DeleteProjectPayload -> FieldDecoder deleteProject RootMutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProject" optionalArgs object


deleteProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectCard Api.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard RootMutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectCard" optionalArgs object


deleteProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectColumn Api.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn RootMutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deleteProjectColumn" optionalArgs object


deletePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deletePullRequestReview Api.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview RootMutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "deletePullRequestReview" optionalArgs object


dismissPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet dismissPullRequestReview Api.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview RootMutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "dismissPullRequestReview" optionalArgs object


moveProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectCard Api.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard RootMutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "moveProjectCard" optionalArgs object


moveProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectColumn Api.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn RootMutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "moveProjectColumn" optionalArgs object


removeOutsideCollaborator : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeOutsideCollaborator Api.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator RootMutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeOutsideCollaborator" optionalArgs object


removeReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeReaction Api.Object.RemoveReactionPayload -> FieldDecoder removeReaction RootMutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeReaction" optionalArgs object


removeStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeStar Api.Object.RemoveStarPayload -> FieldDecoder removeStar RootMutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "removeStar" optionalArgs object


requestReviews : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet requestReviews Api.Object.RequestReviewsPayload -> FieldDecoder requestReviews RootMutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "requestReviews" optionalArgs object


submitPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet submitPullRequestReview Api.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview RootMutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "submitPullRequestReview" optionalArgs object


updateProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProject Api.Object.UpdateProjectPayload -> FieldDecoder updateProject RootMutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProject" optionalArgs object


updateProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectCard Api.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard RootMutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProjectCard" optionalArgs object


updateProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectColumn Api.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn RootMutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateProjectColumn" optionalArgs object


updatePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReview Api.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview RootMutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReview" optionalArgs object


updatePullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReviewComment Api.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment RootMutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updatePullRequestReviewComment" optionalArgs object


updateSubscription : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateSubscription Api.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription RootMutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateSubscription" optionalArgs object


updateTopics : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateTopics Api.Object.UpdateTopicsPayload -> FieldDecoder updateTopics RootMutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.single "updateTopics" optionalArgs object
