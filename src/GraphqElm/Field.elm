module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)


type Query decodesTo
    = Query (List Field) (Decoder decodesTo)


type FieldDecoder decodesTo
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


decoder : Query decodesTo -> Decoder decodesTo
decoder (Query fields decoder) =
    decoder


listAt : String -> FieldDecoder a -> FieldDecoder (List a)
listAt at (FieldDecoder field decoder) =
    FieldDecoder field (decoder |> Decode.list |> Decode.field at)


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


fieldDecoder : String -> Decoder decodesTo -> TypeLocked (FieldDecoder decodesTo) lockedTo
fieldDecoder fieldName decoder =
    FieldDecoder (Leaf fieldName [])
        (decoder |> Decode.at [ fieldName ])
        |> TypeLocked


custom : String -> Decoder decodesTo -> FieldDecoder decodesTo
custom fieldName decoder =
    FieldDecoder (Leaf fieldName [])
        (decoder |> Decode.field fieldName)
