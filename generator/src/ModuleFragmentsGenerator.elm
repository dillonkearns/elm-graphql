module ModuleFragmentsGenerator exposing (init)

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
import ModuleName exposing (ModuleName)


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


type Level
    = Query
    | Mutation
    | Subscription


type alias Name =
    { functionName : String
    , moduleName : ModuleName
    }


type ExposedSelectionSet
    = ExposedSelectionSet Name Level Ast.Canonical.Type


maybeSelectionSetAnnotation : ModuleName -> String -> Ast.Canonical.Type -> Maybe ExposedSelectionSet
maybeSelectionSetAnnotation elmiModuleName functionName type_ =
    case type_ of
        Ast.Canonical.TType moduleName "SelectionSet" typeParameters ->
            case moduleName of
                ElmFile.Module.Name details ->
                    if details.module_ == "Graphql.SelectionSet" then
                        case typeParameters of
                            [ level, selectionType ] ->
                                ExposedSelectionSet { functionName = functionName, moduleName = elmiModuleName } Query selectionType
                                    |> Just

                            _ ->
                                Nothing

                    else
                        Nothing

        _ ->
            Nothing


logger : Int -> Int -> never
logger upper lower =
    Debug.todo ("64 bit number found in binary (" ++ String.fromInt upper ++ " << 32 + " ++ String.fromInt lower ++ ")")
