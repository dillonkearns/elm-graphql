module Graphql.Generator.Scalar exposing (generate)

import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : List String -> List TypeDefinition -> Result String ( List String, String )
generate apiSubmodule typeDefs =
    fileContents apiSubmodule typeDefs
        |> Result.map
            (\contents ->
                ( apiSubmodule ++ [ "Scalar" ], contents )
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


fileContents : List String -> List TypeDefinition -> Result String String
fileContents apiSubmodule typeDefinitions =
    let
        typesToGenerate =
            typeDefinitions
                |> List.filter include

        moduleName =
            apiSubmodule ++ [ "Scalar" ] |> String.join "."
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
                        """module {0} exposing (Codecs, {6}, defaultCodecs, defineCodecs, unwrapCodecs, unwrapEncoder)


import Graphql.Internal.Builder.Object as Object
import Json.Decode as Decode exposing (Decoder)
import Graphql.Internal.Encode
import Json.Encode as Encode
import Graphql.Codec exposing (Codec)


{1}

defineCodecs :
    {2}
    -> Codecs {4}
defineCodecs definitions =
    Codecs definitions


unwrapCodecs :
    Codecs {4}
    -> {2}
unwrapCodecs (Codecs unwrappedCodecs) =
    unwrappedCodecs


unwrapEncoder getter (Codecs unwrappedCodecs) =
    (unwrappedCodecs |> getter |> .encoder) >> Graphql.Internal.Encode.fromJson


type Codecs {4}
    = Codecs (RawCodecs {4})


type alias RawCodecs {4} =
    {2}


defaultCodecs : RawCodecs {7}
defaultCodecs =
    {5}
"""
                        [ moduleName
                        , normalizedNames
                            |> List.map
                                (\name ->
                                    interpolate
                                        """type {0}
                              = {0} String"""
                                        [ name ]
                                )
                            |> String.join "\n\n\n"
                        , "{"
                            ++ (normalizedNames
                                    |> List.map
                                        (\name ->
                                            interpolate "codec{0} : Codec value{0}"
                                                [ name ]
                                        )
                                    |> String.join "\n, "
                               )
                            ++ "}"
                        , "" -- TODO remove this
                        , normalizedNames
                            |> List.map
                                (\name ->
                                    "value" ++ name
                                )
                            |> String.join " "
                        , "{"
                            ++ (normalizedNames
                                    |> List.map
                                        (\name ->
                                            interpolate "codec{0} =\n  { encoder = \\({0} raw) -> Encode.string raw\n , decoder = Object.scalarDecoder |> Decode.map {0} }"
                                                [ name ]
                                        )
                                    |> String.join "\n, "
                               )
                            ++ "}"
                        , normalizedNames
                            |> List.map
                                (\name ->
                                    name ++ "(..)"
                                )
                            |> String.join ", "
                        , normalizedNames
                            |> String.join " "
                        ]
                )
