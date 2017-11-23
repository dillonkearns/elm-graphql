module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type FieldDecoder decodesTo
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


decoder : FieldDecoder decodesTo -> Decoder decodesTo
decoder (FieldDecoder field decoder) =
    decoder


object :
    (a -> constructor)
    -> String
    -> List Argument
    -> FieldDecoder (a -> constructor)
object constructor fieldName args =
    FieldDecoder
        (Composite fieldName args [])
        (Decode.succeed constructor |> Decode.at [ "data", fieldName ])


with : FieldDecoder a -> FieldDecoder (a -> b) -> FieldDecoder b
with (FieldDecoder fieldA decoderA) (FieldDecoder fieldB decoderB) =
    let
        combinedField =
            case fieldB of
                Composite fieldName args children ->
                    Composite fieldName args (fieldA :: children)

                Leaf fieldName args ->
                    fieldB
    in
    FieldDecoder combinedField (Decode.map2 (|>) decoderA decoderB)


fieldDecoderToQuery : FieldDecoder a -> String
fieldDecoderToQuery (FieldDecoder field decoder) =
    toQuery field


toQuery : Field -> String
toQuery field =
    "{\n"
        ++ (case field of
                Composite fieldName args children ->
                    fieldName
                        ++ Argument.toQueryString args
                        ++ " "
                        ++ (children
                                |> List.map toQuery
                                |> String.join "\n"
                           )

                Leaf fieldName args ->
                    fieldName
           )
        ++ "\n}"


string : String -> FieldDecoder String
string fieldName =
    FieldDecoder (Leaf fieldName [])
        (Decode.string |> Decode.at [ "data", "human", fieldName ])


int : String -> FieldDecoder Int
int fieldName =
    FieldDecoder (Leaf fieldName []) (Decode.int |> Decode.field fieldName)
