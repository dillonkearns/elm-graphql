module Graphql.Generator.AnnotatedArg exposing (build, buildWithArgs, prepend, toString)

import String.Interpolate exposing (interpolate)


build : String -> AnnotatedArgs
build returnAnnotation =
    AnnotatedArgs [] returnAnnotation


buildWithArgs : List AnnotatedArg -> String -> AnnotatedArgs
buildWithArgs args returnAnnotation =
    AnnotatedArgs args returnAnnotation


prepend : ( String, String ) -> AnnotatedArgs -> AnnotatedArgs
prepend ( annotation, parameterName ) annotatedArgs =
    { annotatedArgs | args = ( annotation, parameterName ) :: annotatedArgs.args }


toString : String -> AnnotatedArgs -> String
toString functionName { args, returnAnnotation } =
    let
        annotations =
            (args
                |> List.map Tuple.first
            )
                ++ [ returnAnnotation ]

        typeAnnotation =
            interpolate "{0} : {1}"
                [ functionName
                , annotations |> String.join "\n -> "
                ]

        parameterNames =
            args
                |> List.map Tuple.second
    in
    interpolate "{0}\n{1} {2} =\n"
        [ typeAnnotation
        , functionName
        , parameterNames |> String.join " "
        ]


type alias AnnotatedArgs =
    { args : List AnnotatedArg
    , returnAnnotation : String
    }


type alias AnnotatedArg =
    ( String, String )
