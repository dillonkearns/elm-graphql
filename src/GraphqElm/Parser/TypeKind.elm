module Graphqelm.Parser.TypeKind exposing (TypeKind(..), decoder)

import Json.Decode as Decode exposing (Decoder)


type TypeKind
    = Scalar
    | Object
    | List
    | NonNull
    | Ignore
    | Enum
    | Interface



-- | Union
-- | InputObject


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

                    _ ->
                        Decode.succeed Ignore
             -- "INTERFACE" ->
             --     Decode.succeed Interface
             --
             -- "UNION" ->
             --     Decode.succeed Union
             --
             --
             -- "INPUT_OBJECT" ->
             --     Decode.succeed InputObject
             -- _ ->
             --     Decode.fail ("Invalid TypeKind " ++ string)
            )
