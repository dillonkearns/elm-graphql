module Generator.NormalizeTests exposing (all)

import Expect
import Graphqelm.Generator.Normalize as Normalize
import Test exposing (Test, describe, only, test)


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
                Normalize.capitalized "MyInterface"
                    |> Expect.equal "MyInterface"
        , test "module name with leading underscore" <|
            \() ->
                Normalize.capitalized "_ModelMutationType"
                    |> Expect.equal "ModelMutationType_"
        , test "capitalized & underscorized with leading underscore" <|
            \() ->
                Normalize.capitalized "ENUMERATION"
                    |> Expect.equal "Enumeration"
        , test "uppercase with leading underscore" <|
            \() ->
                Normalize.capitalized "_My_Module_Name"
                    |> Expect.equal "MyModuleName_"
        , test "All uppercase underscore-seperated" <|
            \() ->
                Normalize.capitalized "MOBILE_WEB"
                    |> Expect.equal "MobileWeb"
        , test "all lowercase" <|
            \() ->
                Normalize.capitalized "hello"
                    |> Expect.equal "Hello"
        ]
