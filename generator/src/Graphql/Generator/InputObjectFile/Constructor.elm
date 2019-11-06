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
import Result.Extra
import String.Interpolate exposing (interpolate)


generate : Context -> InputObjectDetails -> Result String String
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
    in
    ClassCaseName.normalized name
        |> Result.map
            (\normalizedName ->
                Result.map4
                    (\filledOptionals returnRecord requiredAliases optionalAliases ->
                        let
                            annotation =
                                AnnotatedArg.buildWithArgs
                                    ([ when (List.length requiredFields > 0)
                                        ( interpolate "{0}RequiredFields"
                                            [ normalizedName ]
                                        , "required"
                                        )
                                     , when (List.length optionalFields > 0)
                                        ( interpolate "({0}OptionalFields -> {0}OptionalFields)" [ normalizedName ]
                                        , "fillOptionals"
                                        )
                                     ]
                                        |> compact
                                    )
                                    normalizedName
                                    |> AnnotatedArg.toString ("build" ++ normalizedName)

                            letClause =
                                Let.generate
                                    ([ when (List.length optionalFields > 0)
                                        ( "optionals"
                                        , interpolate """
            fillOptionals
                { {0} }"""
                                            [ filledOptionals ]
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
                                normalizedName

                              else
                                ""
                            , returnRecord
                            , requiredAliases
                            , optionalAliases
                            ]
                    )
                    (filledOptionalsRecord optionalFields)
                    (fields
                        |> List.map
                            (\field ->
                                CamelCaseName.normalized field.name
                                    |> Result.map
                                        (\normalized ->
                                            interpolate "{0} = {1}.{0}"
                                                [ normalized
                                                , case field.typeRef of
                                                    Type.TypeReference referrableType isNullable ->
                                                        case isNullable of
                                                            Type.Nullable ->
                                                                "optionals"

                                                            Type.NonNullable ->
                                                                "required"
                                                ]
                                        )
                            )
                        |> Result.Extra.combine
                        |> Result.map (String.join ", ")
                    )
                    (constructorFieldsAlias (normalizedName ++ "RequiredFields") context requiredFields)
                    (constructorFieldsAlias (normalizedName ++ "OptionalFields") context optionalFields)
            )
        |> Result.andThen identity


constructorFieldsAlias : String -> Context -> List Type.Field -> Result String String
constructorFieldsAlias nameThing context fields =
    if List.isEmpty fields then
        Ok ""

    else
        fields
            |> List.map (aliasEntry context)
            |> Result.Extra.combine
            |> Result.map
                (\aliases ->
                    interpolate
                        """type alias {0} =
    {1}"""
                        [ nameThing, aliases |> GenerateSyntax.typeAlias ]
                )


filledOptionalsRecord : List Type.Field -> Result String String
filledOptionalsRecord =
    List.map (.name >> CamelCaseName.normalized)
        >> Result.Extra.combine
        >> Result.map
            (List.map (\fieldName -> fieldName ++ " = Absent")
                >> String.join ", "
            )


aliasEntry : Context -> Type.Field -> Result String ( String, String )
aliasEntry context field =
    Result.map2 Tuple.pair
        (CamelCaseName.normalized field.name)
        (Decoder.generateTypeForInputObject context field.typeRef)


when : Bool -> value -> Maybe value
when condition value =
    if condition then
        Just value

    else
        Nothing


compact : List (Maybe value) -> List value
compact =
    List.filterMap identity
