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
            """module {0} exposing (Decoders, Id(..), PosixTime(..), defaultDecoders, defineDecoders, unwrapDecoders)


import Graphql.Internal.Builder.Object as Object
import Json.Decode as Decode exposing (Decoder)


{1}



defineDecoders :
    { decoderId : Decoder decoderId
    , decoderPosixTime : Decoder decoderPosixTime
    }
    -> Decoders decoderId decoderPosixTime
defineDecoders definitions =
    Decoders
        { decoderId = definitions.decoderId
        , decoderPosixTime = definitions.decoderPosixTime
        }


unwrapDecoders :
    Decoders decoderId decoderPosixTime
    ->
        { decoderId : Decoder decoderId
        , decoderPosixTime : Decoder decoderPosixTime
        }
unwrapDecoders (Decoders unwrappedDecoders) =
    unwrappedDecoders


type Decoders decoderId decoderPosixTime
    = Decoders (RawDecoders decoderId decoderPosixTime)


type alias RawDecoders decoderId decoderPosixTime =
    { decoderId : Decoder decoderId
    , decoderPosixTime : Decoder decoderPosixTime
    }


defaultDecoders : RawDecoders Id PosixTime
defaultDecoders =
    { decoderId = Object.scalarDecoder |> Decode.map Id
    , decoderPosixTime = Object.scalarDecoder |> Decode.map PosixTime
    }
"""
            [ moduleName
            , typesToGenerate
                |> List.map generateType
                |> String.join "\n\n\n"
            ]


generateType : ClassCaseName -> String
generateType name =
    interpolate
        """type {0}
    = {0} String"""
        [ ClassCaseName.normalized name ]
