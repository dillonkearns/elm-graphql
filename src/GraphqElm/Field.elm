module Graphqelm.Field exposing (..)

import Graphqelm.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type FieldDecoder decodesTo typeLock
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)
    | QueryField Field


spaces : Int -> String
spaces n =
    if n > 0 then
        " " ++ spaces (n - 1)
    else
        ""


indent : Int -> String
indent indentationLevel =
    spaces (indentationLevel * 2)


fieldDecoderToQuery : Bool -> Int -> Field -> String
fieldDecoderToQuery skipIndentationLevel indentationLevel field =
    case field of
        Composite fieldName args children ->
            ((if skipIndentationLevel then
                ""
              else
                indent indentationLevel
             )
                ++ fieldName
                ++ Argument.toQueryString args
                ++ " {\n"
                ++ (children
                        |> List.map (fieldDecoderToQuery False (indentationLevel + 1))
                        |> String.join "\n"
                   )
            )
                ++ "\n"
                ++ indent indentationLevel
                ++ "}"

        Leaf fieldName args ->
            indent indentationLevel ++ fieldName

        QueryField nestedField ->
            fieldDecoderToQuery False indentationLevel nestedField


fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (Leaf fieldName args)
        (decoder |> Decode.field fieldName)


map : (decodesTo -> mapsTo) -> FieldDecoder decodesTo typeLock -> FieldDecoder mapsTo typeLock
map mapFunction (FieldDecoder field decoder) =
    FieldDecoder field (Decode.map mapFunction decoder)
