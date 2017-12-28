module Github.Object.ProtectedBranch exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProtectedBranch
selection constructor =
    Object.object constructor


creator : SelectionSet creator Github.Object.Actor -> FieldDecoder creator Github.Object.ProtectedBranch
creator object =
    Object.selectionFieldDecoder "creator" [] object identity


hasDismissableStaleReviews : FieldDecoder Bool Github.Object.ProtectedBranch
hasDismissableStaleReviews =
    Object.fieldDecoder "hasDismissableStaleReviews" [] Decode.bool


hasRequiredReviews : FieldDecoder Bool Github.Object.ProtectedBranch
hasRequiredReviews =
    Object.fieldDecoder "hasRequiredReviews" [] Decode.bool


hasRequiredStatusChecks : FieldDecoder Bool Github.Object.ProtectedBranch
hasRequiredStatusChecks =
    Object.fieldDecoder "hasRequiredStatusChecks" [] Decode.bool


hasRestrictedPushes : FieldDecoder Bool Github.Object.ProtectedBranch
hasRestrictedPushes =
    Object.fieldDecoder "hasRestrictedPushes" [] Decode.bool


hasRestrictedReviewDismissals : FieldDecoder Bool Github.Object.ProtectedBranch
hasRestrictedReviewDismissals =
    Object.fieldDecoder "hasRestrictedReviewDismissals" [] Decode.bool


hasStrictRequiredStatusChecks : FieldDecoder Bool Github.Object.ProtectedBranch
hasStrictRequiredStatusChecks =
    Object.fieldDecoder "hasStrictRequiredStatusChecks" [] Decode.bool


id : FieldDecoder String Github.Object.ProtectedBranch
id =
    Object.fieldDecoder "id" [] Decode.string


isAdminEnforced : FieldDecoder Bool Github.Object.ProtectedBranch
isAdminEnforced =
    Object.fieldDecoder "isAdminEnforced" [] Decode.bool


name : FieldDecoder String Github.Object.ProtectedBranch
name =
    Object.fieldDecoder "name" [] Decode.string


pushAllowances : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet pushAllowances Github.Object.PushAllowanceConnection -> FieldDecoder pushAllowances Github.Object.ProtectedBranch
pushAllowances fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pushAllowances" optionalArgs object identity


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.ProtectedBranch
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


requiredStatusCheckContexts : FieldDecoder (List String) Github.Object.ProtectedBranch
requiredStatusCheckContexts =
    Object.fieldDecoder "requiredStatusCheckContexts" [] (Decode.string |> Decode.list)


reviewDismissalAllowances : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet reviewDismissalAllowances Github.Object.ReviewDismissalAllowanceConnection -> FieldDecoder reviewDismissalAllowances Github.Object.ProtectedBranch
reviewDismissalAllowances fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reviewDismissalAllowances" optionalArgs object identity
