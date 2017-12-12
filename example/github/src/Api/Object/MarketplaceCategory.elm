module Api.Object.MarketplaceCategory exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MarketplaceCategory
build constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.MarketplaceCategory
description =
    Object.fieldDecoder "description" [] Decode.string


howItWorks : FieldDecoder String Api.Object.MarketplaceCategory
howItWorks =
    Object.fieldDecoder "howItWorks" [] Decode.string


name : FieldDecoder String Api.Object.MarketplaceCategory
name =
    Object.fieldDecoder "name" [] Decode.string


primaryListingCount : FieldDecoder Int Api.Object.MarketplaceCategory
primaryListingCount =
    Object.fieldDecoder "primaryListingCount" [] Decode.int


resourcePath : FieldDecoder String Api.Object.MarketplaceCategory
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


secondaryListingCount : FieldDecoder Int Api.Object.MarketplaceCategory
secondaryListingCount =
    Object.fieldDecoder "secondaryListingCount" [] Decode.int


slug : FieldDecoder String Api.Object.MarketplaceCategory
slug =
    Object.fieldDecoder "slug" [] Decode.string


url : FieldDecoder String Api.Object.MarketplaceCategory
url =
    Object.fieldDecoder "url" [] Decode.string
