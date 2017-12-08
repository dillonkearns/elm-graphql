module Api.Query exposing (..)

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
    Field.fieldDecoder "captains" [] (Decode.string |> Decode.list)
        |> Query.rootQuery


me : Field.Query String
me =
    Field.fieldDecoder "me" [] Decode.string
        |> Query.rootQuery


menuItems : ({ contains : Maybe String } -> { contains : Maybe String }) -> Object menuItems Api.Object.MenuItem -> Field.Query (List menuItems)
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Nothing }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains Encode.string ]
                |> List.filterMap identity
    in
    Object.listOf "menuItems" optionalArgs object
        |> Query.rootQuery


weather : Field.Query Api.Enum.Weather.Weather
weather =
    Field.fieldDecoder "weather" [] Api.Enum.Weather.decoder
        |> Query.rootQuery
