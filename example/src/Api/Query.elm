module Api.Query exposing (..)

import Api.Enum.SortOrder
import Api.Enum.Weather
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> Object (a -> constructor) RootQuery
selection constructor =
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
            [ Argument.optional "contains" filledInOptionals.contains Encode.string, Argument.optional "order" filledInOptionals.order (Encode.enum toString) ]
                |> List.filterMap identity
    in
    RootObject.listOf "menuItems" optionalArgs object


weather : FieldDecoder Api.Enum.Weather.Weather RootQuery
weather =
    RootObject.fieldDecoder "weather" [] Api.Enum.Weather.decoder
