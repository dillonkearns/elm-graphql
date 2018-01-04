module Github.Object.Milestone exposing (..)

import Github.Enum.IssueState
import Github.Enum.MilestoneState
import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Milestone
selection constructor =
    Object.object constructor


{-| `true` if the object is closed (definition of closed may depend on type)
-}
closed : FieldDecoder Bool Github.Object.Milestone
closed =
    Object.fieldDecoder "closed" [] Decode.bool


{-| Identifies the date and time when the object was closed.
-}
closedAt : FieldDecoder (Maybe String) Github.Object.Milestone
closedAt =
    Object.fieldDecoder "closedAt" [] (Decode.string |> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.Milestone
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the actor who created the milestone.
-}
creator : SelectionSet creator Github.Interface.Actor -> FieldDecoder (Maybe creator) Github.Object.Milestone
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| Identifies the description of the milestone.
-}
description : FieldDecoder (Maybe String) Github.Object.Milestone
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| Identifies the due date of the milestone.
-}
dueOn : FieldDecoder (Maybe String) Github.Object.Milestone
dueOn =
    Object.fieldDecoder "dueOn" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.Milestone
id =
    Object.fieldDecoder "id" [] Decode.string


{-| A list of issues associated with the milestone.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - labels - A list of label names to filter the pull requests by.
  - orderBy - Ordering options for issues returned from the connection.
  - states - A list of states to filter the issues by.

-}
issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) }) -> SelectionSet issues Github.Object.IssueConnection -> FieldDecoder issues Github.Object.Milestone
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.IssueState.toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "issues" optionalArgs object identity


{-| Identifies the number of the milestone.
-}
number : FieldDecoder Int Github.Object.Milestone
number =
    Object.fieldDecoder "number" [] Decode.int


{-| The repository associated with this milestone.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Milestone
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| The HTTP path for this milestone
-}
resourcePath : FieldDecoder String Github.Object.Milestone
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| Identifies the state of the milestone.
-}
state : FieldDecoder Github.Enum.MilestoneState.MilestoneState Github.Object.Milestone
state =
    Object.fieldDecoder "state" [] Github.Enum.MilestoneState.decoder


{-| Identifies the title of the milestone.
-}
title : FieldDecoder String Github.Object.Milestone
title =
    Object.fieldDecoder "title" [] Decode.string


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.Milestone
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL for this milestone
-}
url : FieldDecoder String Github.Object.Milestone
url =
    Object.fieldDecoder "url" [] Decode.string
