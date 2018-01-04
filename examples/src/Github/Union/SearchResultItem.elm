module Github.Union.SearchResultItem exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


selection : (Maybe typeSpecific -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Union.SearchResultItem) -> SelectionSet constructor Github.Union.SearchResultItem
selection constructor typeSpecificDecoders =
    Object.unionSelection typeSpecificDecoders constructor


onIssue : SelectionSet selection Github.Object.Issue -> FragmentSelectionSet selection Github.Union.SearchResultItem
onIssue (SelectionSet fields decoder) =
    FragmentSelectionSet "Issue" fields decoder


onPullRequest : SelectionSet selection Github.Object.PullRequest -> FragmentSelectionSet selection Github.Union.SearchResultItem
onPullRequest (SelectionSet fields decoder) =
    FragmentSelectionSet "PullRequest" fields decoder


onRepository : SelectionSet selection Github.Object.Repository -> FragmentSelectionSet selection Github.Union.SearchResultItem
onRepository (SelectionSet fields decoder) =
    FragmentSelectionSet "Repository" fields decoder


onUser : SelectionSet selection Github.Object.User -> FragmentSelectionSet selection Github.Union.SearchResultItem
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


onOrganization : SelectionSet selection Github.Object.Organization -> FragmentSelectionSet selection Github.Union.SearchResultItem
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onMarketplaceListing : SelectionSet selection Github.Object.MarketplaceListing -> FragmentSelectionSet selection Github.Union.SearchResultItem
onMarketplaceListing (SelectionSet fields decoder) =
    FragmentSelectionSet "MarketplaceListing" fields decoder
