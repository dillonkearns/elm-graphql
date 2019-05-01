module Graphql.Parser exposing (decoder, encoder)

import Dict exposing (Dict)
import Graphql.Generator.Group exposing (IntrospectionData, sortedIntrospectionData)
import Graphql.Parser.Type as Type
import Json.Decode as Decode exposing (Decoder)
import ModuleName exposing (ModuleName)


decoder : Decoder IntrospectionData
decoder =
    Decode.map4 sortedIntrospectionData
        (Type.decoder
            |> Decode.list
            |> Decode.at [ "__schema", "types" ]
        )
        (Decode.at [ "__schema", "queryType", "name" ] Decode.string)
        (Decode.maybe (Decode.at [ "__schema", "mutationType", "name" ] Decode.string))
        (Decode.maybe (Decode.at [ "__schema", "subscriptionType", "name" ] Decode.string))

encoder : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> IntrospectionData -> Dict String String
encoder options introspectionData =
    Graphql.Generator.Group.generateFiles options introspectionData