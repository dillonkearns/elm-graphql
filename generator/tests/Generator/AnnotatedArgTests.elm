module Generator.AnnotatedArgTests exposing (all)

import Expect
import Graphql.Generator.AnnotatedArg as AnnotatedArg
import Test exposing (Test, describe, test)


all : Test
all =
    describe "annotated args"
        [ test "return value only" <|
            \() ->
                AnnotatedArg.build "String"
                    |> AnnotatedArg.toString "foo"
                    |> Expect.equal
                        """foo : String
foo  =
"""
        , test "with arg" <|
            \() ->
                AnnotatedArg.build "String"
                    |> AnnotatedArg.prepend ( "Int", "n" )
                    |> AnnotatedArg.toString "intToString"
                    |> Expect.equal
                        """intToString : Int
 -> String
intToString n =
"""
        , test "with two args" <|
            \() ->
                AnnotatedArg.build "String"
                    |> AnnotatedArg.prepend ( "Int", "n" )
                    |> AnnotatedArg.prepend ( "(String -> String)", "mapFn" )
                    |> AnnotatedArg.toString "mapInt"
                    |> Expect.equal
                        """mapInt : (String -> String)
 -> Int
 -> String
mapInt mapFn n =
"""
        , test "two args built with `buildWithArgs`" <|
            \() ->
                AnnotatedArg.buildWithArgs [ ( "(String -> String)", "mapFn" ), ( "Int", "n" ) ] "String"
                    |> AnnotatedArg.toString "mapInt"
                    |> Expect.equal
                        """mapInt : (String -> String)
 -> Int
 -> String
mapInt mapFn n =
"""
        ]
