module Api.Object.ProtectedBranch exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.ProtectedBranch
build constructor =
    Object.object constructor


creator : Object creator Api.Object.Actor -> FieldDecoder creator Api.Object.ProtectedBranch
creator object =
    Object.single "creator" [] object


hasDismissableStaleReviews : FieldDecoder String Api.Object.ProtectedBranch
hasDismissableStaleReviews =
    Field.fieldDecoder "hasDismissableStaleReviews" [] Decode.string


hasRequiredReviews : FieldDecoder String Api.Object.ProtectedBranch
hasRequiredReviews =
    Field.fieldDecoder "hasRequiredReviews" [] Decode.string


hasRequiredStatusChecks : FieldDecoder String Api.Object.ProtectedBranch
hasRequiredStatusChecks =
    Field.fieldDecoder "hasRequiredStatusChecks" [] Decode.string


hasRestrictedPushes : FieldDecoder String Api.Object.ProtectedBranch
hasRestrictedPushes =
    Field.fieldDecoder "hasRestrictedPushes" [] Decode.string


hasRestrictedReviewDismissals : FieldDecoder String Api.Object.ProtectedBranch
hasRestrictedReviewDismissals =
    Field.fieldDecoder "hasRestrictedReviewDismissals" [] Decode.string


hasStrictRequiredStatusChecks : FieldDecoder String Api.Object.ProtectedBranch
hasStrictRequiredStatusChecks =
    Field.fieldDecoder "hasStrictRequiredStatusChecks" [] Decode.string


id : FieldDecoder String Api.Object.ProtectedBranch
id =
    Field.fieldDecoder "id" [] Decode.string


isAdminEnforced : FieldDecoder String Api.Object.ProtectedBranch
isAdminEnforced =
    Field.fieldDecoder "isAdminEnforced" [] Decode.string


name : FieldDecoder String Api.Object.ProtectedBranch
name =
    Field.fieldDecoder "name" [] Decode.string


pushAllowances : Object pushAllowances Api.Object.PushAllowanceConnection -> FieldDecoder pushAllowances Api.Object.ProtectedBranch
pushAllowances object =
    Object.single "pushAllowances" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.ProtectedBranch
repository object =
    Object.single "repository" [] object


requiredStatusCheckContexts : FieldDecoder (List String) Api.Object.ProtectedBranch
requiredStatusCheckContexts =
    Field.fieldDecoder "requiredStatusCheckContexts" [] (Decode.string |> Decode.list)


reviewDismissalAllowances : Object reviewDismissalAllowances Api.Object.ReviewDismissalAllowanceConnection -> FieldDecoder reviewDismissalAllowances Api.Object.ProtectedBranch
reviewDismissalAllowances object =
    Object.single "reviewDismissalAllowances" [] object
