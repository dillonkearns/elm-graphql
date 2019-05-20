module ModuleFragmentsGenerator exposing (generateFile, init)

import Ast.Canonical
import Base64
import Bytes.Decode
import Bytes.Decode.ElmFile.Interface
import Bytes.Encode
import Dict
import ElmFile.Interface
import ElmFile.Module
import ElmFile.Package
import Json.Decode as Decode
import List.Extra
import ModuleName exposing (ModuleName)
import String.Interpolate exposing (interpolate)


type Error
    = DecodingError
    | EncodingBase64Failed


decoder : Decode.Decoder (Result Error (List ExposedSelectionSet))
decoder =
    Decode.list
        (Decode.field "fileName" ModuleName.elmiFilenameDecoder
            |> Decode.andThen
                (\moduleName -> Decode.field "fileContents" (Decode.string |> Decode.map (parseModule moduleName)))
        )
        |> Decode.map
            (\results ->
                results
                    |> combineResults
                    |> Result.map List.concat
            )


generateFile : Result Error (List ExposedSelectionSet) -> String
generateFile result =
    case result of
        Ok exposedSelectionSets ->
            interpolate """module ModuleFragments exposing (..)

import Graphql.Document exposing (serializeFragment)
{0}

generate : String
generate =
    {1}"""
                [ exposedSelectionSets
                    |> List.filter
                        (\(ExposedSelectionSet name decodesTo onType) ->
                            not
                                (ModuleName.startsWith "Swapi" name.moduleName)
                                && not (ModuleName.startsWith "Github" name.moduleName)
                        )
                    |> List.map (\(ExposedSelectionSet name decodesTo onType) -> name.moduleName)
                    |> List.map ModuleName.toImport
                    |> List.Extra.unique
                    |> String.join "\n"
                , exposedSelectionSets
                    |> List.filter
                        (\(ExposedSelectionSet name decodesTo onType) ->
                            not
                                (ModuleName.startsWith "Swapi" name.moduleName)
                                && not (ModuleName.startsWith "Github" name.moduleName)
                        )
                    |> List.map toString
                    |> String.join "\n\n"
                ]

        Err _ ->
            "TODO - ERROR"


toString : ExposedSelectionSet -> String
toString (ExposedSelectionSet name decodesTo onType) =
    interpolate
        """serializeFragment "{1}" "{2}" {0}.{1}"""
        [ name.moduleName |> ModuleName.toString
        , name.functionName
        , onType
        ]



-- "          serializeFragment "droid" "Droid" ExposesSelection.droidSelection"


combineResults : List (Result x a) -> Result x (List a)
combineResults =
    List.foldr (Result.map2 (::)) (Ok [])


init : Decode.Value -> Result Decode.Error (Result Error (List ExposedSelectionSet))
init elmi =
    Decode.decodeValue decoder elmi


parseModule : ModuleName -> String -> Result Error (List ExposedSelectionSet)
parseModule elmiModuleName elmi =
    let
        interface =
            Base64.toBytes elmi
                |> Result.fromMaybe EncodingBase64Failed
                |> Result.andThen
                    (\decodedElmi ->
                        decodedElmi
                            |> Bytes.Decode.decode (Bytes.Decode.ElmFile.Interface.interface logger)
                            |> Result.fromMaybe DecodingError
                    )
    in
    interface
        |> Result.map (\(ElmFile.Interface.Interface i) -> i)
        |> Result.map .types_
        |> Result.map
            (Dict.foldl
                (\functionName (Ast.Canonical.Annotation _ t) accumulator ->
                    maybeSelectionSetAnnotation elmiModuleName functionName t :: accumulator
                )
                []
            )
        |> Result.map (List.filterMap identity)


type alias Name =
    { functionName : String
    , moduleName : ModuleName
    }


type ExposedSelectionSet
    = ExposedSelectionSet Name Ast.Canonical.Type String


maybeSelectionSetAnnotation : ModuleName -> String -> Ast.Canonical.Type -> Maybe ExposedSelectionSet
maybeSelectionSetAnnotation elmiModuleName functionName type_ =
    case type_ of
        Ast.Canonical.TType moduleName "SelectionSet" typeParameters ->
            case moduleName of
                ElmFile.Module.Name details ->
                    if details.module_ == "Graphql.SelectionSet" then
                        case typeParameters of
                            [ level, selectionType ] ->
                                ExposedSelectionSet { functionName = functionName, moduleName = elmiModuleName } selectionType (selectionContextFromType level)
                                    |> Just

                            _ ->
                                Nothing

                    else
                        Nothing

        _ ->
            Nothing


selectionContextFromType : Ast.Canonical.Type -> String
selectionContextFromType selectionContextType =
    case selectionContextType of
        Ast.Canonical.TType nameModuleElmFile selectionContext typeCanonicalAstListList ->
            selectionContext

        _ ->
            "TODO"


logger : Int -> Int -> never
logger upper lower =
    Debug.todo ("64 bit number found in binary (" ++ String.fromInt upper ++ " << 32 + " ++ String.fromInt lower ++ ")")
