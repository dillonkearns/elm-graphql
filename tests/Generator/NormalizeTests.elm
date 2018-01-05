module Generator.NormalizeTests exposing (all)

import Expect
import Graphqelm.Generator.Normalize as Normalize
import Test exposing (Test, describe, test)


all : Test
all =
    describe "normalize"
        [ test "leaves valid names untouched" <|
            \() ->
                Normalize.decapitalized "validFieldName"
                    |> Expect.equal "validFieldName"
        , test "type field name" <|
            \() ->
                Normalize.decapitalized "type"
                    |> Expect.equal "type_"
        , test "already normalized module name" <|
            \() ->
                Normalize.moduleName "MyInterface"
                    |> Expect.equal "MyInterface"
        , test "module name with leading underscore" <|
            \() ->
                Normalize.moduleName "_ModelMutationType"
                    |> Expect.equal "ModelMutationType_"
        ]
