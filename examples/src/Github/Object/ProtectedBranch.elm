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


{-| The actor who created this protected branch.
-}
creator : SelectionSet creator Github.Object.Actor -> FieldDecoder (Maybe creator) Github.Object.ProtectedBranch
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| Will new commits pushed to this branch dismiss pull request review approvals.
-}
hasDismissableStaleReviews : FieldDecoder Bool Github.Object.ProtectedBranch
hasDismissableStaleReviews =
    Object.fieldDecoder "hasDismissableStaleReviews" [] Decode.bool


{-| Are reviews required to update this branch.
-}
hasRequiredReviews : FieldDecoder Bool Github.Object.ProtectedBranch
hasRequiredReviews =
    Object.fieldDecoder "hasRequiredReviews" [] Decode.bool


{-| Are status checks required to update this branch.
-}
hasRequiredStatusChecks : FieldDecoder Bool Github.Object.ProtectedBranch
hasRequiredStatusChecks =
    Object.fieldDecoder "hasRequiredStatusChecks" [] Decode.bool


{-| Is pushing to this branch restricted.
-}
hasRestrictedPushes : FieldDecoder Bool Github.Object.ProtectedBranch
hasRestrictedPushes =
    Object.fieldDecoder "hasRestrictedPushes" [] Decode.bool


{-| Is dismissal of pull request reviews restricted.
-}
hasRestrictedReviewDismissals : FieldDecoder Bool Github.Object.ProtectedBranch
hasRestrictedReviewDismissals =
    Object.fieldDecoder "hasRestrictedReviewDismissals" [] Decode.bool


{-| Are branches required to be up to date before merging.
-}
hasStrictRequiredStatusChecks : FieldDecoder Bool Github.Object.ProtectedBranch
hasStrictRequiredStatusChecks =
    Object.fieldDecoder "hasStrictRequiredStatusChecks" [] Decode.bool


id : FieldDecoder String Github.Object.ProtectedBranch
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Can admins overwrite branch protection.
-}
isAdminEnforced : FieldDecoder Bool Github.Object.ProtectedBranch
isAdminEnforced =
    Object.fieldDecoder "isAdminEnforced" [] Decode.bool


{-| Identifies the name of the protected branch.
-}
name : FieldDecoder String Github.Object.ProtectedBranch
name =
    Object.fieldDecoder "name" [] Decode.string


{-| A list push allowances for this protected branch.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
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


{-| The repository associated with this protected branch.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.ProtectedBranch
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| List of required status check contexts that must pass for commits to be accepted to this branch.
-}
requiredStatusCheckContexts : FieldDecoder (Maybe (List (Maybe String))) Github.Object.ProtectedBranch
requiredStatusCheckContexts =
    Object.fieldDecoder "requiredStatusCheckContexts" [] (Decode.string |> Decode.maybe |> Decode.list |> Decode.maybe)


{-| A list review dismissal allowances for this protected branch.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
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
