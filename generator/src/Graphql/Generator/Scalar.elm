module Graphql.Generator.Scalar exposing (generate)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import String.Interpolate exposing (interpolate)


generate : List String -> List TypeDefinition -> ( List String, String )
generate apiSubmodule typeDefs =
    ( apiSubmodule ++ [ "Scalar" ], fileContents apiSubmodule typeDefs )


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


fileContents : List String -> List TypeDefinition -> String
fileContents apiSubmodule typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filter include
                |> List.map (\(TypeDefinition name definableType description) -> name)

        moduleName =
            apiSubmodule ++ [ "Scalar" ] |> String.join "."
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
            """module {0} exposing (Decoders, {6}, defaultCodecs, defineCodecs, unwrapCodecs)


import Graphql.Internal.Builder.Object as Object
import Json.Decode as Decode exposing (Decoder)


{1}



defineCodecs :
    {2}
    -> Decoders {4}
defineCodecs definitions =
    Decoders
        {3}


unwrapCodecs :
    Decoders {4}
    -> {2}
unwrapCodecs (Decoders unwrappedDecoders) =
    unwrappedDecoders


type Decoders {4}
    = Decoders (RawDecoders {4})


type alias RawDecoders {4} =
    {2}


defaultCodecs : RawDecoders {7}
defaultCodecs =
    {5}
"""
            [ moduleName
            , typesToGenerate
                |> List.map generateType
                |> String.join "\n\n\n"
            , "{"
                ++ (typesToGenerate
                        |> List.map
                            (\classCaseName ->
                                interpolate "decoder{0} : Decoder decoder{0}"
                                    [ ClassCaseName.normalized classCaseName ]
                            )
                        |> String.join "\n, "
                   )
                ++ "}"
            , "{"
                ++ (typesToGenerate
                        |> List.map
                            (\classCaseName ->
                                interpolate "decoder{0} = definitions.decoder{0}"
                                    [ ClassCaseName.normalized classCaseName ]
                            )
                        |> String.join "\n, "
                   )
                ++ "}"
            , typesToGenerate
                |> List.map
                    (\classCaseName ->
                        "decoder"
                            ++ ClassCaseName.normalized classCaseName
                    )
                |> String.join " "
            , "{"
                ++ (typesToGenerate
                        |> List.map
                            (\classCaseName ->
                                interpolate "decoder{0} = Object.scalarDecoder |> Decode.map {0}"
                                    [ ClassCaseName.normalized classCaseName ]
                            )
                        |> String.join "\n, "
                   )
                ++ "}"
            , typesToGenerate
                |> List.map
                    (\classCaseName ->
                        ClassCaseName.normalized classCaseName
                            ++ "(..)"
                    )
                |> String.join ", "
            , typesToGenerate
                |> List.map
                    (\classCaseName ->
                        ClassCaseName.normalized classCaseName
                    )
                |> String.join " "
            ]


generateType : ClassCaseName -> String
generateType name =
    interpolate
        """type {0}
    = {0} String"""
        [ ClassCaseName.normalized name ]
