module Graphqelm.Generator.Argument exposing (requiredArgsAnnotation, requiredArgsString)

import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


requiredArgsString : List Type.Arg -> Maybe String
requiredArgsString args =
    let
        stuff =
            List.filterMap requiredArgString args
    in
    if stuff == [] then
        Nothing
    else
        Just ("[ " ++ (stuff |> String.join "") ++ " ]")


requiredArgString : Type.Arg -> Maybe String
requiredArgString { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            interpolate
                "Argument.string \"{0}\" requiredArgs.{0}"
                [ name ]
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
        Just ("{ " ++ (stuff |> String.join "") ++ " }")


requiredArgAnnotation : Type.Arg -> Maybe String
requiredArgAnnotation { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            interpolate
                "{0} : String"
                [ name ]
                |> Just

        Type.TypeReference referrableType Type.Nullable ->
            Nothing
