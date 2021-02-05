module Graphql.Generator.InputObjectFile.Constructor exposing (generate)

import GenerateSyntax
import Graphql.Generator.AnnotatedArg as AnnotatedArg
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.InputObjectFile.Details exposing (InputObjectDetails)
import Graphql.Generator.Let as Let
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Type as Type exposing (TypeDefinition(..))
import String.Interpolate exposing (interpolate)


generate : Context -> InputObjectDetails -> String
generate context { name, fields, hasLoop } =
    let
        optionalFields =
            fields
                |> List.filter
                    (\field ->
                        case field.typeRef of
                            Type.TypeReference referrableType isNullable ->
                                isNullable == Type.Nullable
                    )

        requiredFields =
            fields
                |> List.filter
                    (\field ->
                        case field.typeRef of
                            Type.TypeReference referrableType isNullable ->
                                isNullable == Type.NonNullable
                    )

        returnRecord =
            fields
                |> List.map
                    (\field ->
                        interpolate "{0} = {1}.{0}"
                            [ CamelCaseName.normalized field.name
                            , case field.typeRef of
                                Type.TypeReference referrableType isNullable ->
                                    case isNullable of
                                        Type.Nullable ->
                                            "optionals____"

                                        Type.NonNullable ->
                                            "required____"
                            ]
                    )
                |> String.join ", "

        annotation =
            AnnotatedArg.buildWithArgs
                ([ when (List.length requiredFields > 0)
                    ( interpolate "{0}RequiredFields" [ ClassCaseName.normalized name ]
                    , "required____"
                    )
                 , when (List.length optionalFields > 0)
                    ( interpolate "({0}OptionalFields -> {0}OptionalFields)" [ ClassCaseName.normalized name ]
                    , "fillOptionals____"
                    )
                 ]
                    |> compact
                )
                (ClassCaseName.normalized name)
                |> AnnotatedArg.toString ("build" ++ ClassCaseName.normalized name)

        letClause =
            Let.generate
                ([ when (List.length optionalFields > 0)
                    ( "optionals____"
                    , interpolate """
            fillOptionals____
                { {0} }"""
                        [ filledOptionalsRecord optionalFields ]
                    )
                 ]
                    |> compact
                )
    in
    interpolate
        """{0}{1}
    {2}{ {3} }

{4}
{5}
"""
        [ annotation
        , letClause
        , if hasLoop then
            ClassCaseName.normalized name

          else
            ""
        , returnRecord
        , constructorFieldsAlias (ClassCaseName.normalized name ++ "RequiredFields") context requiredFields
        , constructorFieldsAlias (ClassCaseName.normalized name ++ "OptionalFields") context optionalFields
        ]


constructorFieldsAlias : String -> Context -> List Type.Field -> String
constructorFieldsAlias nameThing context fields =
    if List.length fields > 0 then
        interpolate
            """type alias {0} =
    {1}"""
            [ nameThing, List.map (aliasEntry context) fields |> GenerateSyntax.typeAlias ]

    else
        ""


filledOptionalsRecord : List Type.Field -> String
filledOptionalsRecord optionalFields =
    optionalFields
        |> List.map .name
        |> List.map (\fieldName -> CamelCaseName.normalized fieldName ++ " = Absent")
        |> String.join ", "


aliasEntry : Context -> Type.Field -> ( String, String )
aliasEntry context field =
    ( CamelCaseName.normalized field.name
    , Decoder.generateTypeForInputObject context field.typeRef
    )


when : Bool -> value -> Maybe value
when condition value =
    if condition then
        Just value

    else
        Nothing


compact : List (Maybe value) -> List value
compact =
    List.filterMap identity
