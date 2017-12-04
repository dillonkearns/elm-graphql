module Api.Query exposing (..)

import Api.Enum.Weather
import Api.Object.MenuItem
import GraphqElm.Argument as Argument
import GraphqElm.Field as Field exposing (Field, FieldDecoder)
import GraphqElm.Object as Object exposing (Object)
import GraphqElm.Query as Query
import Json.Decode as Decode exposing (Decoder)


type Type
    = Type


captains : Field.Query (Maybe (List String))
captains =
    Field.fieldDecoder "captains" (Decode.string |> Decode.list |> Decode.maybe)
        |> Query.rootQuery


me : Field.Query String
me =
    Field.fieldDecoder "me" Decode.string
        |> Query.rootQuery


menuItems : ({ contains : Maybe String } -> { contains : Maybe String }) -> Object menuItems Api.Object.MenuItem.Type -> Field.Query (List menuItems)
menuItems fillInArgs object =
    let
        optionalArgsThing =
            fillInArgs { contains = Nothing }

        optionalArgs =
            [ Maybe.map (\value -> Argument.string "contains" value) optionalArgsThing.contains ]
                |> List.filterMap identity
    in
    Object.listOf "menuItems" optionalArgs object
        |> Query.rootQuery


weather : Field.Query Api.Enum.Weather.Weather
weather =
    Field.fieldDecoder "weather" Api.Enum.Weather.decoder
        |> Query.rootQuery
