module Api.Object.PullRequestReviewThread exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.PullRequestReviewThread
selection constructor =
    Object.object constructor


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Api.Object.PullRequestReviewCommentConnection -> FieldDecoder comments Api.Object.PullRequestReviewThread
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


id : FieldDecoder String Api.Object.PullRequestReviewThread
id =
    Object.fieldDecoder "id" [] Decode.string


pullRequest : SelectionSet pullRequest Api.Object.PullRequest -> FieldDecoder pullRequest Api.Object.PullRequestReviewThread
pullRequest object =
    Object.single "pullRequest" [] object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.PullRequestReviewThread
repository object =
    Object.single "repository" [] object
