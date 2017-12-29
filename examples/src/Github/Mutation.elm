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


acceptTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet acceptTopicSuggestion Github.Object.AcceptTopicSuggestionPayload -> FieldDecoder (Maybe acceptTopicSuggestion) RootMutation
acceptTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "acceptTopicSuggestion" optionalArgs object (identity >> Decode.maybe)


addComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addComment Github.Object.AddCommentPayload -> FieldDecoder (Maybe addComment) RootMutation
addComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addComment" optionalArgs object (identity >> Decode.maybe)


addProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectCard Github.Object.AddProjectCardPayload -> FieldDecoder (Maybe addProjectCard) RootMutation
addProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addProjectCard" optionalArgs object (identity >> Decode.maybe)


addProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addProjectColumn Github.Object.AddProjectColumnPayload -> FieldDecoder (Maybe addProjectColumn) RootMutation
addProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addProjectColumn" optionalArgs object (identity >> Decode.maybe)


addPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReview Github.Object.AddPullRequestReviewPayload -> FieldDecoder (Maybe addPullRequestReview) RootMutation
addPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addPullRequestReview" optionalArgs object (identity >> Decode.maybe)


addPullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addPullRequestReviewComment Github.Object.AddPullRequestReviewCommentPayload -> FieldDecoder (Maybe addPullRequestReviewComment) RootMutation
addPullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addPullRequestReviewComment" optionalArgs object (identity >> Decode.maybe)


addReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addReaction Github.Object.AddReactionPayload -> FieldDecoder (Maybe addReaction) RootMutation
addReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addReaction" optionalArgs object (identity >> Decode.maybe)


addStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet addStar Github.Object.AddStarPayload -> FieldDecoder (Maybe addStar) RootMutation
addStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "addStar" optionalArgs object (identity >> Decode.maybe)


createProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet createProject Github.Object.CreateProjectPayload -> FieldDecoder (Maybe createProject) RootMutation
createProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "createProject" optionalArgs object (identity >> Decode.maybe)


declineTopicSuggestion : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet declineTopicSuggestion Github.Object.DeclineTopicSuggestionPayload -> FieldDecoder (Maybe declineTopicSuggestion) RootMutation
declineTopicSuggestion fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "declineTopicSuggestion" optionalArgs object (identity >> Decode.maybe)


deleteProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProject Github.Object.DeleteProjectPayload -> FieldDecoder (Maybe deleteProject) RootMutation
deleteProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProject" optionalArgs object (identity >> Decode.maybe)


deleteProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectCard Github.Object.DeleteProjectCardPayload -> FieldDecoder (Maybe deleteProjectCard) RootMutation
deleteProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProjectCard" optionalArgs object (identity >> Decode.maybe)


deleteProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deleteProjectColumn Github.Object.DeleteProjectColumnPayload -> FieldDecoder (Maybe deleteProjectColumn) RootMutation
deleteProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deleteProjectColumn" optionalArgs object (identity >> Decode.maybe)


deletePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet deletePullRequestReview Github.Object.DeletePullRequestReviewPayload -> FieldDecoder (Maybe deletePullRequestReview) RootMutation
deletePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deletePullRequestReview" optionalArgs object (identity >> Decode.maybe)


dismissPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet dismissPullRequestReview Github.Object.DismissPullRequestReviewPayload -> FieldDecoder (Maybe dismissPullRequestReview) RootMutation
dismissPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "dismissPullRequestReview" optionalArgs object (identity >> Decode.maybe)


moveProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectCard Github.Object.MoveProjectCardPayload -> FieldDecoder (Maybe moveProjectCard) RootMutation
moveProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "moveProjectCard" optionalArgs object (identity >> Decode.maybe)


moveProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet moveProjectColumn Github.Object.MoveProjectColumnPayload -> FieldDecoder (Maybe moveProjectColumn) RootMutation
moveProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "moveProjectColumn" optionalArgs object (identity >> Decode.maybe)


removeOutsideCollaborator : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeOutsideCollaborator Github.Object.RemoveOutsideCollaboratorPayload -> FieldDecoder (Maybe removeOutsideCollaborator) RootMutation
removeOutsideCollaborator fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeOutsideCollaborator" optionalArgs object (identity >> Decode.maybe)


removeReaction : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeReaction Github.Object.RemoveReactionPayload -> FieldDecoder (Maybe removeReaction) RootMutation
removeReaction fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeReaction" optionalArgs object (identity >> Decode.maybe)


removeStar : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet removeStar Github.Object.RemoveStarPayload -> FieldDecoder (Maybe removeStar) RootMutation
removeStar fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "removeStar" optionalArgs object (identity >> Decode.maybe)


requestReviews : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet requestReviews Github.Object.RequestReviewsPayload -> FieldDecoder (Maybe requestReviews) RootMutation
requestReviews fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "requestReviews" optionalArgs object (identity >> Decode.maybe)


submitPullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet submitPullRequestReview Github.Object.SubmitPullRequestReviewPayload -> FieldDecoder (Maybe submitPullRequestReview) RootMutation
submitPullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "submitPullRequestReview" optionalArgs object (identity >> Decode.maybe)


updateProject : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProject Github.Object.UpdateProjectPayload -> FieldDecoder (Maybe updateProject) RootMutation
updateProject fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProject" optionalArgs object (identity >> Decode.maybe)


updateProjectCard : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectCard Github.Object.UpdateProjectCardPayload -> FieldDecoder (Maybe updateProjectCard) RootMutation
updateProjectCard fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProjectCard" optionalArgs object (identity >> Decode.maybe)


updateProjectColumn : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateProjectColumn Github.Object.UpdateProjectColumnPayload -> FieldDecoder (Maybe updateProjectColumn) RootMutation
updateProjectColumn fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateProjectColumn" optionalArgs object (identity >> Decode.maybe)


updatePullRequestReview : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReview Github.Object.UpdatePullRequestReviewPayload -> FieldDecoder (Maybe updatePullRequestReview) RootMutation
updatePullRequestReview fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updatePullRequestReview" optionalArgs object (identity >> Decode.maybe)


updatePullRequestReviewComment : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updatePullRequestReviewComment Github.Object.UpdatePullRequestReviewCommentPayload -> FieldDecoder (Maybe updatePullRequestReviewComment) RootMutation
updatePullRequestReviewComment fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updatePullRequestReviewComment" optionalArgs object (identity >> Decode.maybe)


updateSubscription : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateSubscription Github.Object.UpdateSubscriptionPayload -> FieldDecoder (Maybe updateSubscription) RootMutation
updateSubscription fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateSubscription" optionalArgs object (identity >> Decode.maybe)


updateTopics : ({ input : OptionalArgument Value } -> { input : OptionalArgument Value }) -> SelectionSet updateTopics Github.Object.UpdateTopicsPayload -> FieldDecoder (Maybe updateTopics) RootMutation
updateTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { input = Absent }

        optionalArgs =
            [ Argument.optional "input" filledInOptionals.input identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "updateTopics" optionalArgs object (identity >> Decode.maybe)
