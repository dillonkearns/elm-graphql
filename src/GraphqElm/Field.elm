module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import Json.Decode as Decode exposing (Decoder)


type RootQuery decodesTo
    = RootQuery (FieldDecoder decodesTo)


rootQuery : FieldDecoder decodesTo -> RootQuery decodesTo
rootQuery (FieldDecoder field decoder) =
    RootQuery (FieldDecoder field (decoder |> Decode.field "data"))


type FieldDecoder decodesTo
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


decoder : RootQuery decodesTo -> Decoder decodesTo
decoder (RootQuery (FieldDecoder field decoder)) =
    decoder


listAt : String -> FieldDecoder a -> FieldDecoder (List a)
listAt at (FieldDecoder field decoder) =
    FieldDecoder field (decoder |> Decode.list |> Decode.field at)


object :
    (a -> constructor)
    -> String
    -> List Argument
    -> FieldDecoder (a -> constructor)
object constructor fieldName args =
    FieldDecoder
        (Composite fieldName args [])
        -- (Decode.succeed constructor |> Decode.at [ fieldName ])
        (Decode.succeed constructor)


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


fieldDecoderToQuery : RootQuery a -> String
fieldDecoderToQuery (RootQuery (FieldDecoder field decoder)) =
    toQuery field


toQuery : Field -> String
toQuery field =
    case field of
        Composite fieldName args children ->
            "{\n"
                ++ (fieldName
                        ++ Argument.toQueryString args
                        ++ " {\n"
                        ++ (children
                                |> List.map toQuery
                                |> String.join "\n"
                           )
                   )
                ++ "\n}"
                ++ "\n}"

        Leaf fieldName args ->
            fieldName


string : String -> FieldDecoder String
string fieldName =
    FieldDecoder (Leaf fieldName [])
        (Decode.string |> Decode.at [ fieldName ])


int : String -> FieldDecoder Int
int fieldName =
    FieldDecoder (Leaf fieldName []) (Decode.int |> Decode.field fieldName)
