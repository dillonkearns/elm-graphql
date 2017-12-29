module Graphqelm.Generator.RequiredArgs exposing (generate)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Normalize as Normalize
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


type alias Result =
    { annotation : String
    , list : String
    }


generate : List Type.Arg -> Maybe Result
generate args =
    Maybe.map2 Result
        (requiredArgsAnnotation args)
        (requiredArgsString args)


requiredArgsString : List Type.Arg -> Maybe String
requiredArgsString args =
    let
        stuff =
            List.filterMap requiredArgString args
    in
    if stuff == [] then
        Nothing
    else
        Just ("[ " ++ (stuff |> String.join ", ") ++ " ]")


requiredArgString : Type.Arg -> Maybe String
requiredArgString { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            interpolate
                "Argument.required \"{0}\" (requiredArgs.{1} |> {2})"
                [ name
                , Normalize.fieldName name
                , Graphqelm.Generator.Decoder.generateEncoder typeRef
                ]
                |> Just

        Type.TypeReference referrableType Type.Nullable ->
            Nothing


requiredArgsAnnotation : List Type.Arg -> Maybe String
requiredArgsAnnotation args =
    let
        stuff =
            List.filterMap requiredArgAnnotation args
    in
    if stuff == [] then
        Nothing
    else
        Just ("{ " ++ (stuff |> String.join ", ") ++ " }")


requiredArgAnnotation : Type.Arg -> Maybe String
requiredArgAnnotation { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            let
                fieldName =
                    Normalize.fieldName name
            in
            interpolate
                "{0} : {1}"
                [ fieldName
                , Graphqelm.Generator.Decoder.generateType [] fieldName typeRef -- TODO apiSubmodule
                ]
                |> Just

        Type.TypeReference referrableType Type.Nullable ->
            Nothing
