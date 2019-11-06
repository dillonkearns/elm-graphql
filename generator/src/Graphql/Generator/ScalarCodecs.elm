module Graphql.Generator.ScalarCodecs exposing (generate)

import Graphql.Generator.Context exposing (Context)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : Context -> List TypeDefinition -> Result String ( List String, String )
generate context typeDefs =
    fileContents context typeDefs
        |> Result.map
            (\contents ->
                ( context.apiSubmodule ++ [ "ScalarCodecs" ]
                , contents
                )
            )


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


fileContents : Context -> List TypeDefinition -> Result String String
fileContents context typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filter include

        moduleName =
            context.apiSubmodule ++ [ "ScalarCodecs" ] |> String.join "."
    in
    if List.isEmpty typesToGenerate then
        interpolate
            """module {0} exposing (..)


placeholder : String
placeholder =
    ""
"""
            [ moduleName ]
            |> Ok

    else
        typesToGenerate
            |> List.map
                (\(TypeDefinition name definableType description) ->
                    ClassCaseName.normalized name
                )
            |> Result.Extra.combine
            |> Result.map
                (\normalizedNames ->
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
                        , normalizedNames
                            |> List.map
                                (\name ->
                                    interpolate
                                        """type alias {0}
                                = {1}"""
                                        [ name
                                        , context.apiSubmodule
                                            ++ [ "Scalar", name ]
                                            |> String.join "."
                                        ]
                                )
                            |> String.join "\n\n\n"
                        , (context.apiSubmodule |> String.join ".")
                            ++ ".Scalar.Codecs "
                            ++ (normalizedNames
                                    |> String.join " "
                               )
                        , normalizedNames
                            |> List.map
                                (\name ->
                                    interpolate "codec{0} = defaultCodecs.codec{0}"
                                        [ name ]
                                )
                            |> String.join "    , "
                        , context.apiSubmodule |> String.join "."
                        ]
                )
