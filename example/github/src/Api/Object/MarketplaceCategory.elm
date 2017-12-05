module Api.Object.MarketplaceCategory exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MarketplaceCategory
build constructor =
    Object.object constructor


description : FieldDecoder String Api.Object.MarketplaceCategory
description =
    Field.fieldDecoder "description" [] Decode.string


howItWorks : FieldDecoder String Api.Object.MarketplaceCategory
howItWorks =
    Field.fieldDecoder "howItWorks" [] Decode.string


name : FieldDecoder String Api.Object.MarketplaceCategory
name =
    Field.fieldDecoder "name" [] Decode.string


primaryListingCount : FieldDecoder String Api.Object.MarketplaceCategory
primaryListingCount =
    Field.fieldDecoder "primaryListingCount" [] Decode.string


resourcePath : FieldDecoder String Api.Object.MarketplaceCategory
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


secondaryListingCount : FieldDecoder String Api.Object.MarketplaceCategory
secondaryListingCount =
    Field.fieldDecoder "secondaryListingCount" [] Decode.string


slug : FieldDecoder String Api.Object.MarketplaceCategory
slug =
    Field.fieldDecoder "slug" [] Decode.string


url : FieldDecoder String Api.Object.MarketplaceCategory
url =
    Field.fieldDecoder "url" [] Decode.string
