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
                    [ "filledInOptionals" => "fillInOptionals { contains = Nothing }"
                    , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains Encode.string ]
|> List.filterMap identity"""
                    ]
                }


type alias OptionalArg =
    { name : String, typeOf : Type.ReferrableType }


annotation : List OptionalArg -> String
annotation optionalArgs =
    """({ contains : Maybe String } -> { contains : Maybe String })"""


optionalArgOrNothing : Type.Arg -> Maybe OptionalArg
optionalArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
