module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type Query decodesTo
    = Query (List Field) (Decoder decodesTo)


type FieldDecoder decodesTo typeLock
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


decoder : Query decodesTo -> Decoder decodesTo
decoder (Query fields decoder) =
    decoder


toQuery : Query a -> String
toQuery (Query fields decoder) =
    "{\n"
        ++ (List.map fieldDecoderToQuery fields |> String.join "\n")
        ++ "\n}"


fieldDecoderToQuery : Field -> String
fieldDecoderToQuery field =
    case field of
        Composite fieldName args children ->
            (fieldName
                ++ Argument.toQueryString args
                ++ " {\n"
                ++ (children
                        |> List.map fieldDecoderToQuery
                        |> String.join "\n"
                   )
            )
                ++ "\n}"

        Leaf fieldName args ->
            fieldName


fieldDecoder : String -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName decoder =
    FieldDecoder (Leaf fieldName [])
        (decoder |> Decode.at [ fieldName ])


custom : String -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
custom fieldName decoder =
    FieldDecoder (Leaf fieldName [])
        (decoder |> Decode.field fieldName)


map : (decodesTo -> mapsTo) -> FieldDecoder decodesTo typeLock -> FieldDecoder mapsTo typeLock
map mapFunction (FieldDecoder field decoder) =
    FieldDecoder field (Decode.map mapFunction decoder)
