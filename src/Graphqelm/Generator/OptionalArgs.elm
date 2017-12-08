module Graphqelm.Generator.OptionalArgs exposing (Result, generate)

import Graphqelm.Generator.Let exposing (LetBinding)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


type alias Result =
    { annotatedArg : { annotation : String, arg : String }
    , letBindings : List LetBinding
    }


type alias OptionalArg =
    { name : String, typeOf : Type.ReferrableType }


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


generate : List Type.Arg -> Maybe Result
generate allArgs =
    case List.filterMap optionalArgOrNothing allArgs of
        [] ->
            Nothing

        optionalArgs ->
            Just
                { annotatedArg =
                    { annotation = annotation optionalArgs
                    , arg = "fillInOptionals"
                    }
                , letBindings =
                    [ "filledInOptionals" => ("fillInOptionals " ++ emptyRecord optionalArgs)
                    , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains Encode.string ]
|> List.filterMap identity"""
                    ]
                }


emptyRecord : List OptionalArg -> String
emptyRecord optionalArgs =
    interpolate
        "{ {0} }"
        [ "contains = Nothing" ]


annotation : List OptionalArg -> String
annotation optionalArgs =
    let
        insideRecord =
            List.map (\{ name, typeOf } -> name ++ " : Maybe String") optionalArgs
                |> String.join ", "
    in
    interpolate """({ {0} } -> { {0} })"""
        [ insideRecord ]


optionalArgOrNothing : Type.Arg -> Maybe OptionalArg
optionalArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
