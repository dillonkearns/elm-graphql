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
            Result.map3
                (\emptyRecord_ optionalArgs_ body ->
                    { annotatedArg =
                        \fieldName ->
                            { annotation = annotation fieldName
                            , arg = "fillInOptionals"
                            }
                    , letBindings =
                        [ ( "filledInOptionals", "fillInOptionals " ++ emptyRecord_ )
                        , ( "optionalArgs"
                          , optionalArgs_
                                ++ "\n                |> List.filterMap identity"
                          )
                        ]
                    , typeAlias =
                        { suffix = "OptionalArguments"
                        , body = body
                        }
                    }
                )
                (emptyRecord optionalArgs)
                (argValues context optionalArgs)
                (typeAlias context optionalArgs)
                |> Result.toMaybe


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
    Result.map2
        (\encoder normalizedName ->
            interpolate
                """Argument.optional "{0}" filledInOptionals.{1} ({2})"""
                [ CamelCaseName.raw name
                , normalizedName
                , encoder
                ]
        )
        (Graphql.Generator.Decoder.generateEncoder context (Type.TypeReference typeOf Type.NonNullable))
        (CamelCaseName.normalized name)


emptyRecord : List OptionalArg -> Result String String
emptyRecord =
    List.map
        (\{ name } ->
            name
                |> CamelCaseName.normalized
                |> Result.map
                    (\normalizedName ->
                        normalizedName ++ " = Absent"
                    )
        )
        >> Result.Extra.combine
        >> Result.map
            (String.join ", "
                >> List.singleton
                >> interpolate "{ {0} }"
            )


annotation : String -> String
annotation fieldName =
    interpolate "({0}OptionalArguments -> {0}OptionalArguments)"
        [ fieldName ]


typeAlias : Context -> List OptionalArg -> Result String String
typeAlias context optionalArgs =
    optionalArgs
        |> List.map
            (\{ name, typeOf } ->
                name
                    |> CamelCaseName.normalized
                    |> Result.andThen
                        (\normalizedName ->
                            Graphql.Generator.Decoder.generateType context (Type.TypeReference typeOf Type.NonNullable)
                                |> Result.map
                                    (\opt ->
                                        ( normalizedName
                                        , "OptionalArgument " ++ opt
                                        )
                                    )
                        )
            )
        |> Result.Extra.combine
        |> Result.map GenerateSyntax.typeAlias


optionalArgOrNothing : Type.Arg -> Maybe OptionalArg
optionalArgOrNothing { name, typeRef } =
    case typeRef of
        Type.TypeReference referrableType Type.NonNullable ->
            Nothing

        Type.TypeReference referrableType Type.Nullable ->
            Just { name = name, typeOf = referrableType }
