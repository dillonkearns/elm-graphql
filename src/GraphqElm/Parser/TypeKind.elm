module GraphqElm.Parser.TypeKind exposing (TypeKind(..), decoder)

import Json.Decode as Decode exposing (Decoder)


type TypeKind
    = Scalar
    | Object
    | Interface
    | Union
    | Enum
    | InputObject
    | List
    | NonNull


decoder : Decoder TypeKind
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "SCALAR" ->
                        Decode.succeed Scalar

                    "OBJECT" ->
                        Decode.succeed Object

                    "INTERFACE" ->
                        Decode.succeed Interface

                    "UNION" ->
                        Decode.succeed Union

                    "ENUM" ->
                        Decode.succeed Enum

                    "INPUT_OBJECT" ->
                        Decode.succeed InputObject

                    "LIST" ->
                        Decode.succeed List

                    "NON_NULL" ->
                        Decode.succeed NonNull

                    _ ->
                        Decode.fail "Invalid TypeKind"
            )
