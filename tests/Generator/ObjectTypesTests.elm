module Generator.ObjectTypesTests exposing (all)

import Expect
import Graphqelm.Generator.ObjectTypes as ObjectTypes
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


definitions : List a
definitions =
    []


all : Test
all =
    describe "object types generator"
        [ test "enum has no object definitions" <|
            \() ->
                [ Type.TypeDefinition "Weather" (Type.EnumType [ "CLOUDY", "SUNNY" ]) ]
                    |> ObjectTypes.generate
                    |> Expect.equal
                        """module Api.Object exposing (..)


placeholder : String
placeholder =
    ""
"""
        ]
