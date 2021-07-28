module Graphql.Generator.OptionalArgs exposing (Result, generate)

import GenerateSyntax
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder
import Graphql.Generator.Let exposing (LetBinding)
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.Type as Type
import String.Interpolate exposing (interpolate)


type alias Result =
    { annotatedArg :
        String
        ->
            { annotation : String
            , arg : String
            }
    , letBindings : List LetBinding
    , typeAlias : { body : String, suffix : String }
    }


type alias OptionalArg =
    { name : CamelCaseName
    , typeOf : Type.ReferrableType
    }


generate : Context -> List Type.Arg -> Maybe Result
generate context allArgs =
    case List.filterMap optionalArgOrNothing allArgs of
        [] ->
            Nothing

        optionalArgs ->
            Just
                { annotatedArg =
                    \fieldName ->
                        { annotation = annotation fieldName
                        , arg = "fillInOptionals____"
                        }
                , letBindings =
                    [ ( "filledInOptionals____", "fillInOptionals____ " ++ emptyRecord optionalArgs )
                    , ( "optionalArgs____"
                      , argValues context optionalArgs
                            ++ "\n                |> List.filterMap Basics.identity"
                      )
                    ]
                , typeAlias = { suffix = "OptionalArguments", body = typeAlias context optionalArgs }
                }


argValues : Context -> List OptionalArg -> String
argValues context optionalArgs =
    let
        values =
            optionalArgs
                |> List.map (argValue context)
                |> String.join ", "
    in
    interpolate "[ {0} ]" [ values ]


argValue : Context -> OptionalArg -> String
argValue context { name, typeOf } =
    interpolate
        """Argument.optional "{0}" filledInOptionals____.{1} ({2})"""
        [ CamelCaseName.raw name
        , CamelCaseName.normalized name
        , Graphql.Generator.Decoder.generateEncoder context (Type.TypeReference typeOf Type.NonNullable)
        ]


emptyRecord : List OptionalArg -> String
emptyRecord optionalArgs =
    let
        recordEntries =
            List.map (\{ name } -> CamelCaseName.normalized name ++ " = Absent") optionalArgs
                |> String.join ", "
    in
    interpolate "{ {0} }" [ recordEntries ]


annotation : String -> String
annotation fieldName =
    interpolate "({0}OptionalArguments -> {0}OptionalArguments)"
        [ fieldName ]


typeAlias : Context -> List OptionalArg -> String
typeAlias context optionalArgs =
    optionalArgs
        |> List.map
            (\{ name, typeOf } ->
                ( CamelCaseName.normalized name
                , "OptionalArgument " ++ Graphql.Generator.Decoder.generateType context (Type.TypeReference typeOf Type.NonNullable)
                )
            )
        |> GenerateSyntax.typeAlias


optionalArgOrNothing : Type.Arg -> Maybe OptionalArg
optionalArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
