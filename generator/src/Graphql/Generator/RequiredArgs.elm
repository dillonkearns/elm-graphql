module Graphql.Generator.RequiredArgs exposing (Result, generate)

import Graphql.Generator.Decoder
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.Type as Type
import String.Interpolate exposing (interpolate)


type alias Result =
    { annotation : String -> String
    , list : String
    , typeAlias : { body : String, suffix : String }
    }


generate : List String -> List Type.Arg -> Maybe Result
generate apiSubmodule args =
    let
        requiredArgs : List RequiredArg
        requiredArgs =
            List.filterMap requiredArgOrNothing args
    in
    if requiredArgs == [] then
        Nothing

    else
        Just
            { annotation = \fieldName -> interpolate "{0}RequiredArguments" [ fieldName ]
            , list = requiredArgsString apiSubmodule requiredArgs
            , typeAlias = { body = requiredArgsAnnotation apiSubmodule requiredArgs, suffix = "RequiredArguments" }
            }


type alias RequiredArg =
    { name : CamelCaseName
    , referrableType : Type.ReferrableType
    , typeRef : Type.TypeReference
    }


requiredArgOrNothing : Type.Arg -> Maybe RequiredArg
requiredArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Just
                { name = name
                , referrableType = referrableType
                , typeRef = typeRef
                }

        Type.TypeReference referrableType Type.Nullable ->
            Nothing


requiredArgsString : List String -> List RequiredArg -> String
requiredArgsString apiSubmodule requiredArgs =
    let
        requiredArgContents =
            List.map (requiredArgString apiSubmodule) requiredArgs
    in
    "[ " ++ (requiredArgContents |> String.join ", ") ++ " ]"


requiredArgString : List String -> RequiredArg -> String
requiredArgString apiSubmodule { name, referrableType, typeRef } =
    interpolate
        "Argument.required \"{0}\" requiredArgs.{1} ({2})"
        [ name |> CamelCaseName.raw
        , name |> CamelCaseName.normalized
        , Graphql.Generator.Decoder.generateEncoder apiSubmodule typeRef
        ]


requiredArgsAnnotation : List String -> List RequiredArg -> String
requiredArgsAnnotation apiSubmodule requiredArgs =
    let
        annotations =
            List.map (requiredArgAnnotation apiSubmodule) requiredArgs
    in
    "{ " ++ (annotations |> String.join ", ") ++ " }"


requiredArgAnnotation : List String -> RequiredArg -> String
requiredArgAnnotation apiSubmodule { name, typeRef } =
    interpolate
        "{0} : {1}"
        [ name |> CamelCaseName.normalized
        , Graphql.Generator.Decoder.generateType apiSubmodule typeRef
        ]
