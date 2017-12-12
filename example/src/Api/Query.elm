module Api.Query exposing (..)

import Api.Enum.SortOrder
import Api.Enum.Weather
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.RootObject as RootObject
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    RootObject.object constructor


captains : FieldDecoder (List String) RootQuery
captains =
    RootObject.fieldDecoder "captains" [] (Decode.string |> Decode.list)


me : FieldDecoder String RootQuery
me =
    RootObject.fieldDecoder "me" [] Decode.string


menuItems : ({ contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder } -> { contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder }) -> Object menuItems Api.Object.MenuItem -> FieldDecoder (List menuItems) RootQuery
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Nothing, order = Nothing }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains Value.string, Argument.optional "order" filledInOptionals.order (Value.enum toString) ]
                |> List.filterMap identity
    in
    RootObject.listOf "menuItems" optionalArgs object


weather : FieldDecoder Api.Enum.Weather.Weather RootQuery
weather =
    RootObject.fieldDecoder "weather" [] Api.Enum.Weather.decoder
