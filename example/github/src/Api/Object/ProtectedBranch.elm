module Api.Object.ProtectedBranch exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.ProtectedBranch
selection constructor =
    Object.object constructor


creator : SelectionSet creator Api.Object.Actor -> FieldDecoder creator Api.Object.ProtectedBranch
creator object =
    Object.single "creator" [] object


hasDismissableStaleReviews : FieldDecoder Bool Api.Object.ProtectedBranch
hasDismissableStaleReviews =
    Object.fieldDecoder "hasDismissableStaleReviews" [] Decode.bool


hasRequiredReviews : FieldDecoder Bool Api.Object.ProtectedBranch
hasRequiredReviews =
    Object.fieldDecoder "hasRequiredReviews" [] Decode.bool


hasRequiredStatusChecks : FieldDecoder Bool Api.Object.ProtectedBranch
hasRequiredStatusChecks =
    Object.fieldDecoder "hasRequiredStatusChecks" [] Decode.bool


hasRestrictedPushes : FieldDecoder Bool Api.Object.ProtectedBranch
hasRestrictedPushes =
    Object.fieldDecoder "hasRestrictedPushes" [] Decode.bool


hasRestrictedReviewDismissals : FieldDecoder Bool Api.Object.ProtectedBranch
hasRestrictedReviewDismissals =
    Object.fieldDecoder "hasRestrictedReviewDismissals" [] Decode.bool


hasStrictRequiredStatusChecks : FieldDecoder Bool Api.Object.ProtectedBranch
hasStrictRequiredStatusChecks =
    Object.fieldDecoder "hasStrictRequiredStatusChecks" [] Decode.bool


id : FieldDecoder String Api.Object.ProtectedBranch
id =
    Object.fieldDecoder "id" [] Decode.string


isAdminEnforced : FieldDecoder Bool Api.Object.ProtectedBranch
isAdminEnforced =
    Object.fieldDecoder "isAdminEnforced" [] Decode.bool


name : FieldDecoder String Api.Object.ProtectedBranch
name =
    Object.fieldDecoder "name" [] Decode.string


pushAllowances : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet pushAllowances Api.Object.PushAllowanceConnection -> FieldDecoder pushAllowances Api.Object.ProtectedBranch
pushAllowances fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "pushAllowances" optionalArgs object


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.ProtectedBranch
repository object =
    Object.single "repository" [] object


requiredStatusCheckContexts : FieldDecoder (List String) Api.Object.ProtectedBranch
requiredStatusCheckContexts =
    Object.fieldDecoder "requiredStatusCheckContexts" [] (Decode.string |> Decode.list)


reviewDismissalAllowances : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet reviewDismissalAllowances Api.Object.ReviewDismissalAllowanceConnection -> FieldDecoder reviewDismissalAllowances Api.Object.ProtectedBranch
reviewDismissalAllowances fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "reviewDismissalAllowances" optionalArgs object
