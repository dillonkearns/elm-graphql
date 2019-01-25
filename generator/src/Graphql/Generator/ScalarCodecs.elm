module Graphql.Generator.ScalarCodecs exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import String.Interpolate exposing (interpolate)


generate : Context -> List TypeDefinition -> ( List String, String )
generate context typeDefs =
    ( context.apiSubmodule ++ [ "ScalarCodecs" ], fileContents context typeDefs )


include : TypeDefinition -> Bool
include (TypeDefinition name definableType description) =
    isScalar definableType
        && not (isBuiltIn name)



-- "Boolean", "String", "ID", "Int", "Float",
-- "DateTime", "Date",
-- "URI"
-- "HTML", "GitObjectID", "GitTimestamp", "X509Certificate", "GitSSHRemote"


builtInNames : List String
builtInNames =
    [ "Boolean"
    , "String"
    , "Int"
    , "Float"

    -- , "ID"
    ]


isBuiltIn : ClassCaseName -> Bool
isBuiltIn name =
    List.member (ClassCaseName.raw name) builtInNames


isScalar : Type.DefinableType -> Bool
isScalar definableType =
    case definableType of
        Type.ScalarType ->
            True

        _ ->
            False


fileContents : Context -> List TypeDefinition -> String
fileContents context typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filter include
                |> List.map (\(TypeDefinition name definableType description) -> name)

        moduleName =
            context.apiSubmodule ++ [ "ScalarCodecs" ] |> String.join "."
    in
    if typesToGenerate == [] then
        interpolate
            """module {0} exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ moduleName ]

    else
        interpolate
            """module {0} exposing (..)

import Json.Decode as Decode exposing (Decoder)
import {4}.Scalar exposing (defaultCodecs)


{1}


codecs : {2}
codecs =
    {4}.Scalar.defineCodecs
        {
        {3}
        }
"""
            [ moduleName
            , typesToGenerate
                |> List.map (generateType context)
                |> String.join "\n\n\n"
            , (context.apiSubmodule |> String.join ".")
                ++ ".Scalar.Codecs "
                ++ (typesToGenerate
                        |> List.map
                            (\classCaseName ->
                                ClassCaseName.normalized classCaseName
                            )
                        |> String.join " "
                   )
            , typesToGenerate
                |> List.map
                    (\classCaseName ->
                        interpolate "codec{0} = defaultCodecs.codec{0}"
                            [ ClassCaseName.normalized classCaseName ]
                    )
                |> String.join "    , "
            , context.apiSubmodule |> String.join "."
            ]


generateType : Context -> ClassCaseName -> String
generateType context name =
    interpolate
        """type alias {0}
    = {1}"""
        [ ClassCaseName.normalized name
        , context.apiSubmodule
            ++ [ "Scalar", ClassCaseName.normalized name ]
            |> String.join "."
        ]
