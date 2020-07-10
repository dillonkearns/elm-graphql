module Generator.NormalizeTests exposing (all)

import Expect
import Graphql.Generator.Normalize as Normalize
import Test exposing (Test, describe, only, test)


all : Test
all =
    describe "normalize"
        [ test "leaves valid names untouched" <|
            \() ->
                Normalize.decapitalized "validCamelCaseName"
                    |> Expect.equal "validCamelCaseName"
        , test "adds the word 'underscore' in front a single _ to make it a valid identifier" <|
            \() ->
                Normalize.decapitalized "_"
                    |> Expect.equal "underscore_"
        , test "adds the word 'underscore' in front of underscore-only names with multiple underscores" <|
            \() ->
                Normalize.decapitalized "__"
                    |> Expect.equal "underscore__"
        , test "leaves valid snake_case names untouched" <|
            \() ->
                Normalize.decapitalized "year_budget"
                    |> Expect.equal "year_budget"
        , test "corrects casing on otherwise valid snake_case names" <|
            \() ->
                Normalize.capitalized "year_budget"
                    |> Expect.equal "Year_budget"
        , test "already normalized module name" <|
            \() ->
                Normalize.capitalized "MyInterface"
                    |> Expect.equal "MyInterface"
        , test "module name with leading underscore" <|
            \() ->
                Normalize.capitalized "_ModelMutationType"
                    |> Expect.equal "ModelMutationType_"
        , test "normalizes all uppercase names to capitalized" <|
            \() ->
                Normalize.capitalized "ENUMERATION"
                    |> Expect.equal "Enumeration"
        , test "uppercase with leading underscore" <|
            \() ->
                Normalize.capitalized "_My_Module_Name"
                    |> Expect.equal "My_Module_Name_"
        , test "normalizes enums that follow convention into class case" <|
            \() ->
                Normalize.capitalized "MOBILE_WEB"
                    |> Expect.equal "MobileWeb"
        , test "leaves unconventional but valid names untouched" <|
            \() ->
                Normalize.capitalized "BillingSubscriptions_UpdateBillingEmailsPayload"
                    |> Expect.equal "BillingSubscriptions_UpdateBillingEmailsPayload"
        , test "fixes first letter only in all lowercase" <|
            \() ->
                Normalize.capitalized "hello"
                    |> Expect.equal "Hello"
        , test "fixes single letter names" <|
            \() ->
                Normalize.decapitalized "X"
                    |> Expect.equal "x"
        , test "puts multiple leading underscores to the back" <|
            \() ->
                Normalize.decapitalized "________x"
                    |> Expect.equal "x________"
        , describe "reserved words"
            [ test "type" <|
                \() ->
                    Normalize.decapitalized "type"
                        |> Expect.equal "type_"
            , test "where" <|
                \() ->
                    Normalize.decapitalized "where"
                        |> Expect.equal "where_"
            , test "of" <|
                \() ->
                    Normalize.decapitalized "of"
                        |> Expect.equal "of_"
            , test "infix" <|
                \() ->
                    Normalize.decapitalized "infix"
                        |> Expect.equal "infix_"
            ]
        ]
