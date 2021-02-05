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
import MyDebug
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


generateForObject : Context -> ClassCaseName -> Type.Field -> String
generateForObject context thisObjectName field =
    toFieldGenerator context field
        |> forObject_ context (ModuleName.object context thisObjectName) field


generateForInterface : Context -> String -> Type.Field -> String
generateForInterface context thisObjectName field =
    toFieldGenerator context field
        |> forObject_ context (ModuleName.interface context (ClassCaseName.build thisObjectName)) field


forObject_ : Context -> List String -> Type.Field -> FieldGenerator -> String
forObject_ context thisObjectName field fieldGenerator =
    fieldGeneratorToString (interpolate "SelectionSet {0} {1}" [ fieldGenerator.decoderAnnotation, thisObjectName |> String.join "." ]) field fieldGenerator


fieldGeneratorToString : String -> Type.Field -> FieldGenerator -> String
fieldGeneratorToString returnAnnotation field fieldGenerator =
    let
        fieldTypeAnnotation =
            ((fieldGenerator.annotatedArgs |> List.map .annotation)
                ++ [ returnAnnotation ]
            )
                |> String.join "\n -> "
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
        , field.name |> CamelCaseName.normalized
        , Let.generate fieldGenerator.letBindings
        , fieldGenerator.objectDecoderChain |> Maybe.withDefault ""
        , DocComment.generate field
        ]
        |> Just
    ]
        |> List.filterMap identity
        |> String.join "\n\n"


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


toFieldGenerator : Context -> Type.Field -> FieldGenerator
toFieldGenerator ({ apiSubmodule } as context) field =
    init context field.name field.typeRef
        |> addRequiredArgs field context field.args
        |> addOptionalArgs field context field.args


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
                    , arg = "requiredArgs____"
                    }

        Nothing ->
            fieldGenerator


addOptionalArgs : Type.Field -> Context -> List Type.Arg -> FieldGenerator -> FieldGenerator
addOptionalArgs field context args fieldGenerator =
    case Graphql.Generator.OptionalArgs.generate context args of
        Just { annotatedArg, letBindings, typeAlias } ->
            { fieldGenerator
                | fieldArgs = "optionalArgs____" :: fieldGenerator.fieldArgs
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


objectThing : Context -> TypeReference -> String -> ObjectOrInterface -> FieldGenerator
objectThing context typeRef refName objectOrInterface =
    let
        scope =
            case ReferenceLeaf.get typeRef of
                ReferenceLeaf.Object ->
                    ModuleName.object context (ClassCaseName.build refName) |> String.join "."

                ReferenceLeaf.Interface ->
                    ModuleName.interface context (ClassCaseName.build refName) |> String.join "."

                ReferenceLeaf.Enum ->
                    MyDebug.crash "TODO"

                ReferenceLeaf.Union ->
                    ModuleName.union context (ClassCaseName.build refName) |> String.join "."

                ReferenceLeaf.Scalar ->
                    MyDebug.crash "TODO"

        objectArgAnnotation =
            interpolate
                "SelectionSet decodesTo {0}"
                [ scope ]
    in
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = Graphql.Generator.Decoder.generateType context typeRef
    , decoder = "object____"
    , otherThing = ".selectionForCompositeField"
    , letBindings = []
    , objectDecoderChain =
        " ("
            ++ (Graphql.Generator.Decoder.generateDecoder context typeRef
                    |> String.join " >> "
               )
            ++ ")"
            |> Just
    , typeAliases = []
    }
        |> prependArg
            { annotation = objectArgAnnotation
            , arg = "object____"
            }


prependArg : AnnotatedArg -> FieldGenerator -> FieldGenerator
prependArg ({ annotation, arg } as annotatedArg) fieldGenerator =
    { fieldGenerator | annotatedArgs = annotatedArg :: fieldGenerator.annotatedArgs }


type LeafRef
    = ObjectLeaf String
    | InterfaceLeaf String
    | UnionLeaf String
    | EnumLeaf
    | ScalarLeaf


leafType : TypeReference -> LeafRef
leafType (Type.TypeReference referrableType isNullable) =
    case referrableType of
        Type.ObjectRef refName ->
            ObjectLeaf refName

        Type.InterfaceRef refName ->
            InterfaceLeaf refName

        Type.UnionRef refName ->
            UnionLeaf refName

        Type.Scalar _ ->
            ScalarLeaf

        Type.List nestedReferrableType ->
            leafType nestedReferrableType

        Type.EnumRef _ ->
            EnumLeaf

        Type.InputObjectRef _ ->
            MyDebug.crash "Unexpected type"


init : Context -> CamelCaseName -> TypeReference -> FieldGenerator
init ({ apiSubmodule } as context) fieldName ((Type.TypeReference referrableType isNullable) as typeRef) =
    case leafType typeRef of
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


initScalarField : Context -> TypeReference -> FieldGenerator
initScalarField context typeRef =
    let
        scalarName =
            "\"" ++ Graphql.Generator.Decoder.generateType { context | apiSubmodule = [] } typeRef ++ "\""
    in
    { annotatedArgs = []
    , fieldArgs = []
    , decoderAnnotation = Graphql.Generator.Decoder.generateType context typeRef
    , decoder =
        Graphql.Generator.Decoder.generateDecoder context typeRef
            |> String.join " |> "
    , otherThing = ".selectionForField " ++ scalarName
    , letBindings = []
    , objectDecoderChain = Nothing
    , typeAliases = []
    }
