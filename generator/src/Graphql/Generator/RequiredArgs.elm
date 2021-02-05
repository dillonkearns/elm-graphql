module Graphql.Generator.RequiredArgs exposing (Result, generate)

import GenerateSyntax
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.Type as Type
import String.Interpolate exposing (interpolate)


type alias Result =
    { annotation : String -> String
    , list : String
    , typeAlias : { body : String, suffix : String }
    }


generate : Context -> List Type.Arg -> Maybe Result
generate context args =
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
            , list = requiredArgsString context requiredArgs
            , typeAlias = { body = requiredArgsAnnotation context requiredArgs, suffix = "RequiredArguments" }
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


requiredArgsString : Context -> List RequiredArg -> String
requiredArgsString context requiredArgs =
    let
        requiredArgContents =
            List.map (requiredArgString context) requiredArgs
    in
    "[ " ++ (requiredArgContents |> String.join ", ") ++ " ]"


requiredArgString : Context -> RequiredArg -> String
requiredArgString context { name, referrableType, typeRef } =
    interpolate
        "Argument.required \"{0}\" requiredArgs____.{1} ({2})"
        [ name |> CamelCaseName.raw
        , name |> CamelCaseName.normalized
        , Graphql.Generator.Decoder.generateEncoder context typeRef
        ]


requiredArgsAnnotation : Context -> List RequiredArg -> String
requiredArgsAnnotation context requiredArgs =
    requiredArgs
        |> List.map (requiredArgAnnotation context)
        |> GenerateSyntax.typeAlias


requiredArgAnnotation : Context -> RequiredArg -> ( String, String )
requiredArgAnnotation context { name, typeRef } =
    ( name |> CamelCaseName.normalized
    , Graphql.Generator.Decoder.generateType context typeRef
    )
