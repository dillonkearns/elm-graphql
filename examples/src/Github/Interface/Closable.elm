module Github.Interface.Closable exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.Closable
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.Closable) -> SelectionSet (a -> constructor) Github.Interface.Closable
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Interface.Closable
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onMilestone : SelectionSet selection Github.Object.Milestone -> FragmentSelectionSet selection Github.Interface.Closable
onMilestone (SelectionSet fields decoder) =
    FragmentSelectionSet "Milestone" fields decoder


onProject : SelectionSet selection Github.Object.Project -> FragmentSelectionSet selection Github.Interface.Closable
onProject (SelectionSet fields decoder) =
    FragmentSelectionSet "Project" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Interface.Closable
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


{-| `true` if the object is closed (definition of closed may depend on type)
-}
closed : FieldDecoder Bool Github.Interface.Closable
closed =
    Object.fieldDecoder "closed" [] Decode.bool


{-| Identifies the date and time when the object was closed.
-}
closedAt : FieldDecoder (Maybe String) Github.Interface.Closable
closedAt =
    Object.fieldDecoder "closedAt" [] (Decode.string |> Decode.maybe)
