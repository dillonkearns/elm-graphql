module Generator.OptionalArgsTests exposing (all)

import Expect
import GenerateSyntax
import Graphql.Generator.Context as Context
import Graphql.Generator.Let exposing (LetBinding)
import Graphql.Generator.OptionalArgs as OptionalArgs
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Scalar as Scalar
import Graphql.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "optional args generator"
        [ test "no args" <|
            \() ->
                []
                    |> OptionalArgs.generate Context.stub
                    |> Expect.equal Nothing
        , test "no optional args, only required" <|
            \() ->
                [ { name = CamelCaseName.build "id"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                  }
                ]
                    |> OptionalArgs.generate Context.stub
                    |> Expect.equal Nothing
        , test "with an optional string arg" <|
            \() ->
                [ { name = CamelCaseName.build "contains"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate Context.stub
                    |> expectResult
                        { typeAlias = "{ contains : OptionalArgument String }"
                        , letBindings =
                            [ ( "filledInOptionals____", "fillInOptionals____ { contains = Absent }" )
                            , ( "optionalArgs____", """[ Argument.optional "contains" filledInOptionals____.contains (Encode.string) ]
                |> List.filterMap Basics.identity""" )
                            ]
                        }
        , test "with multiple optional string args" <|
            \() ->
                [ { name = CamelCaseName.build "id"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                , { name = CamelCaseName.build "contains"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate Context.stub
                    |> expectResult
                        { typeAlias = GenerateSyntax.typeAlias [ ( "id", "OptionalArgument String" ), ( "contains", "OptionalArgument String" ) ]
                        , letBindings =
                            [ ( "filledInOptionals____", "fillInOptionals____ { id = Absent, contains = Absent }" )
                            , ( "optionalArgs____", """[ Argument.optional "id" filledInOptionals____.id (Encode.string), Argument.optional "contains" filledInOptionals____.contains (Encode.string) ]
                |> List.filterMap Basics.identity""" )
                            ]
                        }
        , test "with an optional int arg" <|
            \() ->
                [ { name = CamelCaseName.build "first"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.Int) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate Context.stub
                    |> expectResult
                        { letBindings =
                            [ ( "filledInOptionals____", "fillInOptionals____ { first = Absent }" )
                            , ( "optionalArgs____", """[ Argument.optional "first" filledInOptionals____.first (Encode.int) ]
                |> List.filterMap Basics.identity""" )
                            ]
                        , typeAlias = "{ first : OptionalArgument Int }"
                        }
        , test "with an optional enum arg" <|
            \() ->
                [ { name = CamelCaseName.build "episode"
                  , description = Nothing
                  , typeRef = Type.TypeReference ("Episode" |> ClassCaseName.build |> Type.EnumRef) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate Context.stub
                    |> expectResult
                        { typeAlias = "{ episode : OptionalArgument Api.Enum.Episode.Episode }"
                        , letBindings =
                            [ ( "filledInOptionals____", "fillInOptionals____ { episode = Absent }" )
                            , ( "optionalArgs____", """[ Argument.optional "episode" filledInOptionals____.episode ((Encode.enum Api.Enum.Episode.toString)) ]
                |> List.filterMap Basics.identity""" )
                            ]
                        }
        ]


expectResult :
    { letBindings : List LetBinding
    , typeAlias : String
    }
    -> Maybe OptionalArgs.Result
    -> Expect.Expectation
expectResult expected actual =
    actual
        |> Maybe.map
            (\value ->
                { letBindings = value.letBindings
                , typeAlias = value.typeAlias.body
                }
            )
        |> Expect.equal (Just expected)
