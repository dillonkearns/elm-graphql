module ModuleFragmentsGenerator exposing (init)

import Ast.Canonical
import Base64
import Bytes.Decode
import Bytes.Decode.ElmFile.Interface
import Bytes.Encode
import Debug
import Dict
import ElmFile.Interface
import ElmFile.Module
import ElmFile.Package


type Error
    = DecodingError
    | EncodingBase64Failed


init : String -> ( (), Cmd never )
init elmi =
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

        exposedSelectionSets =
            interface
                |> Result.map (\(ElmFile.Interface.Interface i) -> i)
                |> Result.map .types_
                |> Result.map
                    (Dict.foldl
                        (\name (Ast.Canonical.Annotation _ t) ts ->
                            let
                                _ =
                                    logIfSelectionSet t
                            in
                            [ logIfSelectionSet t ]
                        )
                        []
                    )
                |> Debug.log "exposed"
    in
    ( (), Cmd.none )


logIfSelectionSet : Ast.Canonical.Type -> Maybe ExposedSelectionSet
logIfSelectionSet type_ =
    maybeSelectionSetAnnotation type_


type Level
    = Query
    | Mutation
    | Subscription


type ExposedSelectionSet
    = ExposedSelectionSet Level Ast.Canonical.Type


maybeSelectionSetAnnotation : Ast.Canonical.Type -> Maybe ExposedSelectionSet
maybeSelectionSetAnnotation type_ =
    case type_ of
        Ast.Canonical.TType moduleName "SelectionSet" typeParameters ->
            case moduleName of
                ElmFile.Module.Name details ->
                    if details.module_ == "Graphql.SelectionSet" then
                        case typeParameters of
                            [ level, selectionType ] ->
                                ExposedSelectionSet Query selectionType
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
