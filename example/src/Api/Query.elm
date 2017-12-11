module Api.Query exposing (..)

import Api.Enum.SortOrder
import Api.Enum.Weather
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Document exposing (RootQuery)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    Object.object constructor


captains : FieldDecoder (List String) RootQuery
captains =
    Object.fieldDecoderQuery "captains" [] (Decode.string |> Decode.list)


me : FieldDecoder String RootQuery
me =
    Object.fieldDecoderQuery "me" [] Decode.string


menuItems : ({ contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder } -> { contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder }) -> Object menuItems Api.Object.MenuItem -> FieldDecoder (List menuItems) RootQuery
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Nothing, order = Nothing }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains Value.string, Argument.optional "order" filledInOptionals.order (Value.enum toString) ]
                |> List.filterMap identity
    in
    Object.queryListOf "menuItems" optionalArgs object


weather : FieldDecoder Api.Enum.Weather.Weather RootQuery
weather =
    Object.fieldDecoder "weather" [] Api.Enum.Weather.decoder
