module Api.Object.MarketplaceListingEdge exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MarketplaceListingEdge
build constructor =
    Object.object constructor


cursor : FieldDecoder String Api.Object.MarketplaceListingEdge
cursor =
    Object.fieldDecoder "cursor" [] Decode.string


node : Object node Api.Object.MarketplaceListing -> FieldDecoder node Api.Object.MarketplaceListingEdge
node object =
    Object.single "node" [] object
