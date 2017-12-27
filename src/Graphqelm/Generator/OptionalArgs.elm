module Graphqelm.Generator.OptionalArgs exposing (Result, generate)

import Graphqelm.Generator.Decoder
import Graphqelm.Generator.Let exposing (LetBinding)
import Graphqelm.Parser.Type as Type
import Interpolate exposing (interpolate)


type alias Result =
    { annotatedArg :
        { annotation : String
        , arg : String
        }
    , letBindings : List LetBinding
    }


type alias OptionalArg =
    { name : String
    , typeOf : Type.ReferrableType
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
                    [ "filledInOptionals" => ("fillInOptionals " ++ emptyRecord optionalArgs)
                    , "optionalArgs"
                        => (argValues optionalArgs
                                ++ "\n                |> List.filterMap identity"
                           )
                    ]
                }


argValues : List OptionalArg -> String
argValues optionalArgs =
    let
        values =
            optionalArgs
                |> List.map argValue
                |> String.join ", "
    in
    interpolate "[ {0} ]" [ values ]


argValue : OptionalArg -> String
argValue { name, typeOf } =
    interpolate
        """Argument.optional "{0}" filledInOptionals.{0} ({1})"""
        [ name, Graphqelm.Generator.Decoder.generateEncoder (Type.TypeReference typeOf Type.NonNullable) ]


emptyRecord : List OptionalArg -> String
emptyRecord optionalArgs =
    let
        recordEntries =
            List.map (\{ name } -> name ++ " = Nothing") optionalArgs
                |> String.join ", "
    in
    interpolate "{ {0} }" [ recordEntries ]


annotation : List OptionalArg -> String
annotation optionalArgs =
    let
        insideRecord =
            List.map (\{ name, typeOf } -> name ++ " : Maybe " ++ Graphqelm.Generator.Decoder.generateType (Type.TypeReference typeOf Type.NonNullable)) optionalArgs
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
