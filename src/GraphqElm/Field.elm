module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
import Json.Decode as Decode exposing (Decoder)


type RootQuery decodesTo
    = RootQuery (List Field) (Decoder decodesTo)


combine : (decodesToA -> decodesToB -> decodesToC) -> RootQuery decodesToA -> RootQuery decodesToB -> RootQuery decodesToC
combine combineFunction (RootQuery fieldsA decoderA) (RootQuery fieldsB decoderB) =
    RootQuery (fieldsA ++ fieldsB) (Decode.map2 combineFunction decoderA decoderB)


rootQuery : FieldDecoder decodesTo -> RootQuery decodesTo
rootQuery (FieldDecoder field decoder) =
    RootQuery [ field ] (decoder |> Decode.field "data")


type FieldDecoder decodesTo
    = FieldDecoder Field (Decoder decodesTo)


type Field
    = Composite String (List Argument) (List Field)
    | Leaf String (List Argument)


decoder : RootQuery decodesTo -> Decoder decodesTo
decoder (RootQuery fields decoder) =
    decoder


listAt : String -> FieldDecoder a -> FieldDecoder (List a)
listAt at (FieldDecoder field decoder) =
    FieldDecoder field (decoder |> Decode.list |> Decode.field at)


toQuery : RootQuery a -> String
toQuery (RootQuery fields decoder) =
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


string : String -> TypeLocked (FieldDecoder String) lockedTo
string fieldName =
    fieldDecoder fieldName Decode.string


int : String -> TypeLocked (FieldDecoder Int) lockedTo
int fieldName =
    fieldDecoder fieldName Decode.int
