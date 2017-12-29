module Github.Object.MarketplaceCategory exposing (..)

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


description : FieldDecoder (Maybe String) Github.Object.MarketplaceCategory
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


howItWorks : FieldDecoder (Maybe String) Github.Object.MarketplaceCategory
howItWorks =
    Object.fieldDecoder "howItWorks" [] (Decode.string |> Decode.maybe)


name : FieldDecoder String Github.Object.MarketplaceCategory
name =
    Object.fieldDecoder "name" [] Decode.string


primaryListingCount : FieldDecoder Int Github.Object.MarketplaceCategory
primaryListingCount =
    Object.fieldDecoder "primaryListingCount" [] Decode.int


resourcePath : FieldDecoder String Github.Object.MarketplaceCategory
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


secondaryListingCount : FieldDecoder Int Github.Object.MarketplaceCategory
secondaryListingCount =
    Object.fieldDecoder "secondaryListingCount" [] Decode.int


slug : FieldDecoder String Github.Object.MarketplaceCategory
slug =
    Object.fieldDecoder "slug" [] Decode.string


url : FieldDecoder String Github.Object.MarketplaceCategory
url =
    Object.fieldDecoder "url" [] Decode.string
