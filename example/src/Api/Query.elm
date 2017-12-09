module Api.Query exposing (..)

import Api.Enum.SortOrder
import Api.Enum.Weather
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


captains : Field.Query (List String)
captains =
    Query.fieldDecoder "captains" [] (Decode.string |> Decode.list)


me : Field.Query String
me =
    Query.fieldDecoder "me" [] Decode.string


menuItems : ({ contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder } -> { contains : Maybe String, order : Maybe Api.Enum.SortOrder.SortOrder }) -> Object menuItems Api.Object.MenuItem -> Field.Query (List menuItems)
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Nothing, order = Nothing }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains Encode.string, Argument.optionalEnum "order" filledInOptionals.order ]
                |> List.filterMap identity
    in
    Query.listOf "menuItems" optionalArgs object


weather : Field.Query Api.Enum.Weather.Weather
weather =
    Query.fieldDecoder "weather" [] Api.Enum.Weather.decoder
