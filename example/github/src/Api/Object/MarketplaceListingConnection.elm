module Api.Object.MarketplaceListingConnection exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MarketplaceListingConnection
build constructor =
    Object.object constructor


edges : FieldDecoder (List Object.MarketplaceListingEdge) Api.Object.MarketplaceListingConnection
edges =
    Field.fieldDecoder "edges" [] (Api.Object.MarketplaceListingEdge.decoder |> Decode.list)


nodes : FieldDecoder (List Object.MarketplaceListing) Api.Object.MarketplaceListingConnection
nodes =
    Field.fieldDecoder "nodes" [] (Api.Object.MarketplaceListing.decoder |> Decode.list)


pageInfo : Object pageInfo Api.Object.PageInfo -> FieldDecoder pageInfo Api.Object.MarketplaceListingConnection
pageInfo object =
    Object.single "pageInfo" [] object


totalCount : FieldDecoder String Api.Object.MarketplaceListingConnection
totalCount =
    Field.fieldDecoder "totalCount" [] Decode.string
