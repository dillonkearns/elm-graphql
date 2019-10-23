module Graphql.Generator.OptionalArgs exposing (OptResult, generate)

import GenerateSyntax
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder
import Graphql.Generator.Let exposing (LetBinding)
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.Type as Type
import Result.Extra
import String.Interpolate exposing (interpolate)


type alias OptResult =
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


generate : Context -> List Type.Arg -> Maybe OptResult
generate context allArgs =
    case List.filterMap optionalArgOrNothing allArgs of
        [] ->
            Nothing

        optionalArgs ->
            optionalArgs
                |> argValues context
                |> Result.toMaybe
                |> Maybe.map
                    (\res ->
                        { annotatedArg =
                            \fieldName ->
                                { annotation = annotation fieldName
                                , arg = "fillInOptionals"
                                }
                        , letBindings =
                            [ ( "filledInOptionals", "fillInOptionals " ++ emptyRecord optionalArgs )
                            , ( "optionalArgs"
                              , res
                                    ++ "\n                |> List.filterMap identity"
                              )
                            ]
                        , typeAlias = { suffix = "OptionalArguments", body = typeAlias context optionalArgs }
                        }
                    )


argValues : Context -> List OptionalArg -> Result String String
argValues context =
    List.map (argValue context)
        >> Result.Extra.combine
        >> Result.map
            (\xs ->
                interpolate "[ {0} ]" [ String.join ", " xs ]
            )


argValue : Context -> OptionalArg -> Result String String
argValue context { name, typeOf } =
    Graphql.Generator.Decoder.generateEncoder context (Type.TypeReference typeOf Type.NonNullable)
        |> Result.map
            (\res ->
                interpolate
                    """Argument.optional "{0}" filledInOptionals.{1} ({2})"""
                    [ CamelCaseName.raw name
                    , CamelCaseName.normalized name
                    , res
                    ]
            )


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
