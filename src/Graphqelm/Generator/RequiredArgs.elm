module Graphqelm.Generator.RequiredArgs exposing (generate)

import Graphqelm.Generator.Decoder
import Graphqelm.Parser.CamelCaseName as CamelCaseName
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


type alias Result =
    { annotation : String
    , list : String
    }


generate : List String -> List Type.Arg -> Maybe Result
generate apiSubmodule args =
    Maybe.map2 Result
        (requiredArgsAnnotation apiSubmodule args)
        (requiredArgsString apiSubmodule args)


requiredArgsString : List String -> List Type.Arg -> Maybe String
requiredArgsString apiSubmodule args =
    let
        stuff =
            List.filterMap (requiredArgString apiSubmodule) args
    in
    if stuff == [] then
        Nothing
    else
        Just ("[ " ++ (stuff |> String.join ", ") ++ " ]")


requiredArgString : List String -> Type.Arg -> Maybe String
requiredArgString apiSubmodule { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            interpolate
                "Argument.required \"{0}\" requiredArgs.{1} ({2})"
                [ name |> CamelCaseName.raw
                , name |> CamelCaseName.normalized
                , Graphqelm.Generator.Decoder.generateEncoder apiSubmodule typeRef
                ]
                |> Just

        Type.TypeReference referrableType Type.Nullable ->
            Nothing


requiredArgsAnnotation : List String -> List Type.Arg -> Maybe String
requiredArgsAnnotation apiSubmodule args =
    let
        requiredArgs =
            List.filterMap (requiredArgAnnotation apiSubmodule) args
    in
    if requiredArgs == [] then
        Nothing
    else
        Just ("{ " ++ (requiredArgs |> String.join ", ") ++ " }")


requiredArgAnnotation : List String -> Type.Arg -> Maybe String
requiredArgAnnotation apiSubmodule { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            interpolate
                "{0} : {1}"
                [ name |> CamelCaseName.normalized
                , Graphqelm.Generator.Decoder.generateType apiSubmodule typeRef
                ]
                |> Just

        Type.TypeReference referrableType Type.Nullable ->
            Nothing
