module Generator.FieldTests exposing (..)

import Expect
import Graphqelm.Generator.Field as Field
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


all : Test
all =
    describe "field generator"
        [ test "simple scalar converts for query" <|
            \() ->
                meField
                    |> Field.forQuery { query = "", mutation = Nothing }
                    |> Expect.equal
                        """me : FieldDecoder String RootQuery
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "converts for object" <|
            \() ->
                meField
                    |> Field.forObject { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """me : FieldDecoder String Api.Object.Foo
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "simple object with no args" <|
            \() ->
                { name = "droid"
                , typeRef = Type.TypeReference (Type.InterfaceRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.forQuery { query = "", mutation = Nothing }
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder droid RootQuery
droid object =
      Object.single "droid" [] (object)
"""
        , test "simple object with no args for object" <|
            \() ->
                { name = "droid"
                , typeRef = Type.TypeReference (Type.InterfaceRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.forObject { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder droid Api.Object.Foo
droid object =
      Object.single "droid" [] (object)
"""
        , test "list of objects with no args" <|
            \() ->
                { name = "droid"
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.InterfaceRef "Droid") Type.NonNullable)) Type.NonNullable
                , args = []
                }
                    |> Field.forObject { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder (List droid) Api.Object.Foo
droid object =
      Object.listOf "droid" [] (object)
"""
        , test "with required args" <|
            \() ->
                { name = "human"
                , typeRef = Type.TypeReference (Type.InterfaceRef "Human") Type.NonNullable
                , args = [ { name = "id", typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable } ]
                }
                    |> Field.forQuery { query = "", mutation = Nothing }
                    |> Expect.equal
                        """human : { id : String } -> SelectionSet human Api.Object.Human -> FieldDecoder human RootQuery
human requiredArgs object =
      Object.single "human" [ Argument.string "id" requiredArgs.id ] (object)
"""
        , test "with optional args" <|
            \() ->
                { name = "menuItems"
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable)) Type.NonNullable
                , args = [ { name = "contains", typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable } ]
                }
                    |> Field.forQuery { query = "", mutation = Nothing }
                    |> Expect.equal
                        """menuItems : ({ contains : Maybe String } -> { contains : Maybe String }) -> SelectionSet menuItems Api.Object.MenuItem -> FieldDecoder (List menuItems) RootQuery
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Nothing }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
                |> List.filterMap identity
    in
      Object.listOf "menuItems" optionalArgs (object)
"""
        , test "normalizes reserved names" <|
            \() ->
                { name = "type"
                , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                , args = []
                }
                    |> Field.forObject { query = "RootQuery", mutation = Nothing } "TreeEntry"
                    |> Expect.equal
                        """type_ : FieldDecoder String Api.Object.TreeEntry
type_ =
      Object.fieldDecoder "type" [] (Decode.string)
"""
        ]


captainsField : Type.Field
captainsField =
    { name = "captains"
    , typeRef =
        Type.TypeReference
            (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
            Type.NonNullable
    , args = []
    }


menuItemsField : Type.Field
menuItemsField =
    { name = "menuItems"
    , typeRef =
        Type.TypeReference
            (Type.List
                (Type.TypeReference
                    (Type.ObjectRef "MenuItem")
                    Type.NonNullable
                )
            )
            Type.NonNullable
    , args = []
    }


menuItemField : Type.Field
menuItemField =
    { name = "menuItem"
    , typeRef = Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable
    , args = []
    }


meField : Type.Field
meField =
    { name = "me"
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
