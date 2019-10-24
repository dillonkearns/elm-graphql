module Graphql.Generator.Field exposing (generateForInterface, generateForObject)

import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder
import Graphql.Generator.DocComment as DocComment
import Graphql.Generator.Let as Let exposing (LetBinding)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Generator.OptionalArgs
import Graphql.Generator.ReferenceLeaf as ReferenceLeaf
import Graphql.Generator.RequiredArgs
import Graphql.Parser.CamelCaseName as CamelCaseName exposing (CamelCaseName)
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.Type as Type exposing (TypeReference)
import String.Extra
import String.Interpolate exposing (interpolate)


type alias FieldGenerator =
    { annotatedArgs : List AnnotatedArg
    , decoderAnnotation : String
    , decoder : String
    , fieldArgs : List String
    , otherThing : String
    , letBindings : List LetBinding
    , objectDecoderChain : Maybe String
    , typeAliases : List { suffix : String, body : String }
    }


type alias AnnotatedArg =
    { annotation : String
    , arg : String
    }


generateForObject : Context -> ClassCaseName -> Type.Field -> Result String String
generateForObject context thisObjectName field =
    Result.map2
        (\fieldGen object ->
            forObject_ context object field fieldGen
        )
        (toFieldGenerator context field)
        (ModuleName.object context thisObjectName)
        |> Result.andThen identity


generateForInterface : Context -> String -> Type.Field -> Result String String
generateForInterface context thisObjectName field =
    Result.map2
        (\fieldGen object ->
            forObject_ context object field fieldGen
        )
        (toFieldGenerator context field)
        (ModuleName.interface context (ClassCaseName.build thisObjectName))
        |> Result.andThen identity


forObject_ : Context -> List String -> Type.Field -> FieldGenerator -> Result String String
forObject_ context thisObjectName field fieldGenerator =
    fieldGeneratorToString (interpolate "SelectionSet {0} {1}" [ fieldGenerator.decoderAnnotation, thisObjectName |> String.join "." ]) field fieldGenerator


fieldGeneratorToString : String -> Type.Field -> FieldGenerator -> Result String String
fieldGeneratorToString returnAnnotation field fieldGenerator =
    Result.map2
        (\docComment normalized ->
            let
                fieldTypeAnnotation =
                    ((fieldGenerator.annotatedArgs |> List.map .annotation)
                        ++ [ returnAnnotation ]
                    )
                        |> String.join " -> "
            in
            [ typeAliasesToString field fieldGenerator
            , interpolate
                """{9}{6} : {3}
{6} {4}={7}
      {5} "{0}" {1} ({2}){8}
"""
                [ field.name |> CamelCaseName.raw
                , fieldGenerator |> fieldArgsString
                , fieldGenerator.decoder
                , fieldTypeAnnotation
                , argsListString fieldGenerator
                , "Object" ++ fieldGenerator.otherThing
                , normalized
                , Let.generate fieldGenerator.letBindings
                , fieldGenerator.objectDecoderChain |> Maybe.withDefault ""
                , docComment
                ]
                |> Just
            ]
                |> List.filterMap identity
                |> String.join "\n\n"
        )
        (DocComment.generate field)
        (CamelCaseName.normalized field.name)


typeAliasesToString : Type.Field -> FieldGenerator -> Maybe String
typeAliasesToString field fieldGenerator =
    if fieldGenerator.typeAliases == [] then
        Nothing

    else
        fieldGenerator.typeAliases
            |> List.map
                (\{ suffix, body } ->
                    interpolate "type alias {0}{1} = {2}"
                        [ field.name
                            |> CamelCaseName.raw
                            |> String.Extra.classify
                        , suffix
                        , body
                        ]
                )
            |> String.join "\n\n"
            |> Just


argsListString : { fieldGenerator | annotatedArgs : List AnnotatedArg } -> String
argsListString { annotatedArgs } =
    if annotatedArgs == [] then
        ""

    else
        (annotatedArgs |> List.map .arg |> String.join " ") ++ " "


fieldArgsString : { thing | fieldArgs : List String } -> String
fieldArgsString { fieldArgs } =
    case fieldArgs of
        [] ->
            "[]"

        [ single ] ->
            single

        _ ->
            "(" ++ String.join " ++ " fieldArgs ++ ")"


toFieldGenerator : Context -> Type.Field -> Result String FieldGenerator
toFieldGenerator ({ apiSubmodule } as context) field =
    init context field.name field.typeRef
        |> Result.map
            (addRequiredArgs field context field.args
                >> addOptionalArgs field context field.args
            )


addRequiredArgs : Type.Field -> Context -> List Type.Arg -> FieldGenerator -> FieldGenerator
addRequiredArgs field context args fieldGenerator =
    case Graphql.Generator.RequiredArgs.generate context args of
        Just { annotation, list, typeAlias } ->
            { fieldGenerator
                | fieldArgs = [ list ]
                , typeAliases = typeAlias :: fieldGenerator.typeAliases
            }
                |> prependArg
                    { annotation =
                        annotation
                            (field.name
                                |> CamelCaseName.raw
                                |> String.Extra.classify
                            )
                    , arg = "requiredArgs"
                    }

        Nothing ->
            fieldGenerator


addOptionalArgs : Type.Field -> Context -> List Type.Arg -> FieldGenerator -> FieldGenerator
addOptionalArgs field context args fieldGenerator =
    case Graphql.Generator.OptionalArgs.generate context args of
        Just { annotatedArg, letBindings, typeAlias } ->
            { fieldGenerator
                | fieldArgs = "optionalArgs" :: fieldGenerator.fieldArgs
                , letBindings = fieldGenerator.letBindings ++ letBindings
                , typeAliases = typeAlias :: fieldGenerator.typeAliases
            }
                |> prependArg
                    (annotatedArg
                        (field.name
                            |> CamelCaseName.raw
                            |> String.Extra.classify
                        )
                    )

        Nothing ->
            fieldGenerator


type ObjectOrInterface
    = Object
    | Interface


objectThing : Context -> TypeReference -> String -> ObjectOrInterface -> Result String FieldGenerator
objectThing context typeRef refName objectOrInterface =
    Result.map3
        (\typeLock decoders decoderAnnotation ->
            let
                objectArgAnnotation =
                    interpolate
                        "SelectionSet decodesTo {0}"
                        [ typeLock ]
            in
            { annotatedArgs = []
            , fieldArgs = []
            , decoderAnnotation = decoderAnnotation
            , decoder = "object_"
            , otherThing = ".selectionForCompositeField"
            , letBindings = []
            , objectDecoderChain =
                " ("
                    ++ (decoders
                            |> String.join " >> "
                       )
                    ++ ")"
                    |> Just
            , typeAliases = []
            }
                |> prependArg
                    { annotation = objectArgAnnotation
                    , arg = "object_"
                    }
        )
        (typeRef
            |> ReferenceLeaf.get
            |> Result.andThen
                (\res ->
                    case res of
                        ReferenceLeaf.Object ->
                            ModuleName.object context (ClassCaseName.build refName)
                                |> Result.map (String.join ".")

                        ReferenceLeaf.Interface ->
                            ModuleName.interface context (ClassCaseName.build refName)
                                |> Result.map (String.join ".")

                        ReferenceLeaf.Enum ->
                            Err "TODO"

                        ReferenceLeaf.Union ->
                            ModuleName.union context (ClassCaseName.build refName)
                                |> Result.map (String.join ".")

                        ReferenceLeaf.Scalar ->
                            Err "TODO"
                )
        )
        (Graphql.Generator.Decoder.generateDecoder context typeRef)
        (Graphql.Generator.Decoder.generateType context typeRef)


prependArg : AnnotatedArg -> FieldGenerator -> FieldGenerator
prependArg ({ annotation, arg } as annotatedArg) fieldGenerator =
    { fieldGenerator | annotatedArgs = annotatedArg :: fieldGenerator.annotatedArgs }


type LeafRef
    = ObjectLeaf String
    | InterfaceLeaf String
    | UnionLeaf String
    | EnumLeaf
    | ScalarLeaf


leafType : TypeReference -> Result String LeafRef
leafType (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.ObjectRef refName ->
            ObjectLeaf refName
                |> Ok

        Type.InterfaceRef refName ->
            InterfaceLeaf refName
                |> Ok

        Type.UnionRef refName ->
            UnionLeaf refName
                |> Ok

        Type.Scalar _ ->
            ScalarLeaf
                |> Ok

        Type.List nestedReferrableType ->
            leafType nestedReferrableType

        Type.EnumRef _ ->
            EnumLeaf
                |> Ok

        Type.InputObjectRef _ ->
            Err "Unexpected type"


init : Context -> CamelCaseName -> TypeReference -> Result String FieldGenerator
init ({ apiSubmodule } as context) fieldName ((Type.TypeReference referrableType isNullable) as typeRef) =
    typeRef
        |> leafType
        |> Result.andThen
            (\res ->
                case res of
                    ObjectLeaf refName ->
                        objectThing context typeRef refName Object

                    InterfaceLeaf refName ->
                        objectThing context typeRef refName Interface

                    UnionLeaf refName ->
                        objectThing context typeRef refName Interface

                    EnumLeaf ->
                        initScalarField context typeRef

                    ScalarLeaf ->
                        initScalarField context typeRef
            )


initScalarField : Context -> TypeReference -> Result String FieldGenerator
initScalarField context typeRef =
    Result.map3
        (\decoders decoderAnnotation scalarType ->
            let
                scalarName =
                    "\"" ++ scalarType ++ "\""
            in
            { annotatedArgs = []
            , fieldArgs = []
            , decoderAnnotation = decoderAnnotation
            , decoder =
                decoders
                    |> String.join " |> "
            , otherThing = ".selectionForField " ++ scalarName
            , letBindings = []
            , objectDecoderChain = Nothing
            , typeAliases = []
            }
        )
        (Graphql.Generator.Decoder.generateDecoder context typeRef)
        (Graphql.Generator.Decoder.generateType context typeRef)
        (Graphql.Generator.Decoder.generateType { context | apiSubmodule = [] } typeRef)
