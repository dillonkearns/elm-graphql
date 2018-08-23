module TypeKindTests exposing (all)

import Expect
import Graphql.Parser.TypeKind as TypeKind exposing (TypeKind(..))
import Json.Decode as Decode exposing (Decoder)
import Test exposing (..)


all : Test
all =
    describe "typekind decoder"
        [ test "decodes scalar" <|
            \_ ->
                "\"SCALAR\""
                    |> Decode.decodeString TypeKind.decoder
                    |> Expect.equal (Ok Scalar)
        , test "decodes TypeKind" <|
            \_ ->
                "\"NON_NULL\""
                    |> Decode.decodeString TypeKind.decoder
                    |> Expect.equal (Ok NonNull)
        ]
