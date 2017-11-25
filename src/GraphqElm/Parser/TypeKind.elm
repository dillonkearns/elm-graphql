module GraphqElm.Parser.TypeKind exposing (TypeKind(..), decoder)

import Json.Decode as Decode exposing (Decoder)


type TypeKind
    = Scalar
    | Object
    | List
    | NonNull



-- | Interface
-- | Union
-- | Enum
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

                    -- "INTERFACE" ->
                    --     Decode.succeed Interface
                    --
                    -- "UNION" ->
                    --     Decode.succeed Union
                    --
                    -- "ENUM" ->
                    --     Decode.succeed Enum
                    --
                    -- "INPUT_OBJECT" ->
                    --     Decode.succeed InputObject
                    _ ->
                        Decode.fail "Invalid TypeKind"
            )
