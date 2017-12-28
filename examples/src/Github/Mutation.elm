module Github.Mutation exposing (..)

import Github.Object
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


acceptTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet acceptTopicSuggestion Github.Object.AcceptTopicSuggestionPayload -> FieldDecoder acceptTopicSuggestion RootMutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "acceptTopicSuggestion" optionalArgs object identity


addComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addComment Github.Object.AddCommentPayload -> FieldDecoder addComment RootMutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addComment" optionalArgs object identity


addProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectCard Github.Object.AddProjectCardPayload -> FieldDecoder addProjectCard RootMutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addProjectCard" optionalArgs object identity


addProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectColumn Github.Object.AddProjectColumnPayload -> FieldDecoder addProjectColumn RootMutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addProjectColumn" optionalArgs object identity


addPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReview Github.Object.AddPullRequestReviewPayload -> FieldDecoder addPullRequestReview RootMutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addPullRequestReview" optionalArgs object identity


addPullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReviewComment Github.Object.AddPullRequestReviewCommentPayload -> FieldDecoder addPullRequestReviewComment RootMutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addPullRequestReviewComment" optionalArgs object identity


addReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addReaction Github.Object.AddReactionPayload -> FieldDecoder addReaction RootMutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addReaction" optionalArgs object identity


addStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addStar Github.Object.AddStarPayload -> FieldDecoder addStar RootMutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addStar" optionalArgs object identity


createProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet createProject Github.Object.CreateProjectPayload -> FieldDecoder createProject RootMutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "createProject" optionalArgs object identity


declineTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet declineTopicSuggestion Github.Object.DeclineTopicSuggestionPayload -> FieldDecoder declineTopicSuggestion RootMutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "declineTopicSuggestion" optionalArgs object identity


deleteProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProject Github.Object.DeleteProjectPayload -> FieldDecoder deleteProject RootMutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProject" optionalArgs object identity


deleteProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectCard Github.Object.DeleteProjectCardPayload -> FieldDecoder deleteProjectCard RootMutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProjectCard" optionalArgs object identity


deleteProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectColumn Github.Object.DeleteProjectColumnPayload -> FieldDecoder deleteProjectColumn RootMutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProjectColumn" optionalArgs object identity


deletePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deletePullRequestReview Github.Object.DeletePullRequestReviewPayload -> FieldDecoder deletePullRequestReview RootMutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deletePullRequestReview" optionalArgs object identity


dismissPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet dismissPullRequestReview Github.Object.DismissPullRequestReviewPayload -> FieldDecoder dismissPullRequestReview RootMutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "dismissPullRequestReview" optionalArgs object identity


moveProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectCard Github.Object.MoveProjectCardPayload -> FieldDecoder moveProjectCard RootMutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "moveProjectCard" optionalArgs object identity


moveProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectColumn Github.Object.MoveProjectColumnPayload -> FieldDecoder moveProjectColumn RootMutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "moveProjectColumn" optionalArgs object identity


removeOutsideCollaborator : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeOutsideCollaborator Github.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder removeOutsideCollaborator RootMutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeOutsideCollaborator" optionalArgs object identity


removeReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeReaction Github.Object.RemoveReactionPayload -> FieldDecoder removeReaction RootMutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeReaction" optionalArgs object identity


removeStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeStar Github.Object.RemoveStarPayload -> FieldDecoder removeStar RootMutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeStar" optionalArgs object identity


requestReviews : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet requestReviews Github.Object.RequestReviewsPayload -> FieldDecoder requestReviews RootMutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "requestReviews" optionalArgs object identity


submitPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet submitPullRequestReview Github.Object.SubmitPullRequestReviewPayload -> FieldDecoder submitPullRequestReview RootMutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "submitPullRequestReview" optionalArgs object identity


updateProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProject Github.Object.UpdateProjectPayload -> FieldDecoder updateProject RootMutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProject" optionalArgs object identity


updateProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectCard Github.Object.UpdateProjectCardPayload -> FieldDecoder updateProjectCard RootMutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProjectCard" optionalArgs object identity


updateProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectColumn Github.Object.UpdateProjectColumnPayload -> FieldDecoder updateProjectColumn RootMutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProjectColumn" optionalArgs object identity


updatePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReview Github.Object.UpdatePullRequestReviewPayload -> FieldDecoder updatePullRequestReview RootMutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updatePullRequestReview" optionalArgs object identity


updatePullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReviewComment Github.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder updatePullRequestReviewComment RootMutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updatePullRequestReviewComment" optionalArgs object identity


updateSubscription : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateSubscription Github.Object.UpdateSubscriptionPayload -> FieldDecoder updateSubscription RootMutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateSubscription" optionalArgs object identity


updateTopics : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateTopics Github.Object.UpdateTopicsPayload -> FieldDecoder updateTopics RootMutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateTopics" optionalArgs object identity
