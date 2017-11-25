module GraphqElm.Field exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.TypeLock exposing (TypeLocked(TypeLocked))
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


fieldDecoderToQuery : RootQuery a -> String
fieldDecoderToQuery (RootQuery (FieldDecoder field decoder)) =
    "{\n"
        ++ toQuery field
        ++ "\n}"


toQuery : Field -> String
toQuery field =
    case field of
        Composite fieldName args children ->
            (fieldName
                ++ Argument.toQueryString args
                ++ " {\n"
                ++ (children
                        |> List.map toQuery
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
