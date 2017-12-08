module Generator.OptionalArgsTests exposing (all)

import Expect
import Graphqelm.Generator.OptionalArgs as OptionalArgs
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "optional args generator"
        [ test "no args" <|
            \() ->
                []
                    |> OptionalArgs.generate
                    |> Expect.equal Nothing
        , test "no optional args, only required" <|
            \() ->
                [ { name = "id"
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                  }
                ]
                    |> OptionalArgs.generate
                    |> Expect.equal Nothing
        , test "with an optional arg" <|
            \() ->
                [ { name = "contains"
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate
                    |> Expect.equal
                        (Just
                            { annotatedArg =
                                { annotation = """({ contains : Maybe String } -> { contains : Maybe String })"""
                                , arg = "fillInOptionals"
                                }
                            , letBindings =
                                [ "filledInOptionals" => "fillInOptionals { contains = Nothing }"
                                , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains Encode.string ]
|> List.filterMap identity"""
                                ]
                            }
                        )
        ]


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
