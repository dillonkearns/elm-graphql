module Graphqelm.Generator.OptionalArgs exposing (Result, generate)

import Graphqelm.Generator.Let exposing (LetBinding)
import Graphqelm.Parser.Type as Type


type alias Result =
    { annotatedArg : { annotation : String, arg : String }
    , letBindings : List LetBinding
    }


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


generate : List Type.Arg -> Maybe Result
generate args =
    case List.filterMap generateSingle args of
        [] ->
            Nothing

        optionalArgs ->
            Just
                { annotatedArg =
                    { annotation = """({ contains : Maybe String } -> { contains : Maybe String })"""
                    , arg = "fillInOptionals"
                    }
                , letBindings =
                    [ "filledInOptionals" => "fillInOptionals { contains = Nothing }"
                    , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains Encode.string ]
|> List.filterMap identity"""
                    ]
                }


generateSingle : Type.Arg -> Maybe { name : String, typeOf : Type.ReferrableType }
generateSingle { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
