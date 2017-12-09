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
        , test "with an optional string arg" <|
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
                                , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
|> List.filterMap identity"""
                                ]
                            }
                        )
        , test "with multiple optional string args" <|
            \() ->
                [ { name = "id"
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                , { name = "contains"
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate
                    |> Expect.equal
                        (Just
                            { annotatedArg =
                                { annotation = "({ id : Maybe String, contains : Maybe String } -> { id : Maybe String, contains : Maybe String })"
                                , arg = "fillInOptionals"
                                }
                            , letBindings =
                                [ "filledInOptionals" => "fillInOptionals { id = Nothing, contains = Nothing }"
                                , "optionalArgs" => """[ Argument.optional "id" filledInOptionals.id (Encode.string), Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
|> List.filterMap identity"""
                                ]
                            }
                        )
        , test "with an optional int arg" <|
            \() ->
                [ { name = "first"
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.Int) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate
                    |> Expect.equal
                        (Just
                            { annotatedArg =
                                { annotation = """({ first : Maybe Int } -> { first : Maybe Int })"""
                                , arg = "fillInOptionals"
                                }
                            , letBindings =
                                [ "filledInOptionals" => "fillInOptionals { first = Nothing }"
                                , "optionalArgs" => """[ Argument.optional "first" filledInOptionals.first (Encode.int) ]
|> List.filterMap identity"""
                                ]
                            }
                        )
        , test "with an optional enum arg" <|
            \() ->
                [ { name = "episode"
                  , typeRef = Type.TypeReference (Type.EnumRef "Episode") Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate
                    |> Expect.equal
                        (Just
                            { annotatedArg =
                                { annotation = """({ episode : Maybe Api.Enum.Episode.Episode } -> { episode : Maybe Api.Enum.Episode.Episode })"""
                                , arg = "fillInOptionals"
                                }
                            , letBindings =
                                [ "filledInOptionals" => "fillInOptionals { episode = Nothing }"
                                , "optionalArgs" => """[ Argument.optionalEnum "episode" filledInOptionals.episode ]
|> List.filterMap identity"""
                                ]
                            }
                        )
        ]


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
