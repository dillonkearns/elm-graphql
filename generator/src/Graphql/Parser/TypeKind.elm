module Graphql.Parser.TypeKind exposing (TypeKind(..), decoder)

import Json.Decode as Decode exposing (Decoder)


type TypeKind
    = Scalar
    | Object
    | List
    | NonNull
    | Ignore
    | Enum
    | Interface
    | InputObject
    | Union


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

                    "LIST" ->
                        Decode.succeed List

                    "NON_NULL" ->
                        Decode.succeed NonNull

                    "ENUM" ->
                        Decode.succeed Enum

                    "INTERFACE" ->
                        Decode.succeed Interface

                    "INPUT_OBJECT" ->
                        Decode.succeed InputObject

                    "UNION" ->
                        Decode.succeed Union

                    _ ->
                        Decode.fail ("Invalid TypeKind" ++ string)
            )
