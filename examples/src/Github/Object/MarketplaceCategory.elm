module Github.Object.MarketplaceCategory exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MarketplaceCategory
selection constructor =
    Object.object constructor


{-| The category's description.
-}
description : FieldDecoder (Maybe String) Github.Object.MarketplaceCategory
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| The technical description of how apps listed in this category work with GitHub.
-}
howItWorks : FieldDecoder (Maybe String) Github.Object.MarketplaceCategory
howItWorks =
    Object.fieldDecoder "howItWorks" [] (Decode.string |> Decode.maybe)


{-| The category's name.
-}
name : FieldDecoder String Github.Object.MarketplaceCategory
name =
    Object.fieldDecoder "name" [] Decode.string


{-| How many Marketplace listings have this as their primary category.
-}
primaryListingCount : FieldDecoder Int Github.Object.MarketplaceCategory
primaryListingCount =
    Object.fieldDecoder "primaryListingCount" [] Decode.int


{-| The HTTP path for this Marketplace category.
-}
resourcePath : FieldDecoder String Github.Object.MarketplaceCategory
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| How many Marketplace listings have this as their secondary category.
-}
secondaryListingCount : FieldDecoder Int Github.Object.MarketplaceCategory
secondaryListingCount =
    Object.fieldDecoder "secondaryListingCount" [] Decode.int


{-| The short name of the category used in its URL.
-}
slug : FieldDecoder String Github.Object.MarketplaceCategory
slug =
    Object.fieldDecoder "slug" [] Decode.string


{-| The HTTP URL for this Marketplace category.
-}
url : FieldDecoder String Github.Object.MarketplaceCategory
url =
    Object.fieldDecoder "url" [] Decode.string
