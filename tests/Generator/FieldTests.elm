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
                    |> Field.generate [ "Api" ] { query = "RootQueryObject", mutation = Nothing } "RootQueryObject"
                    |> Expect.equal
                        """me : FieldDecoder String RootQuery
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "converts for object" <|
            \() ->
                meField
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """me : FieldDecoder String Api.Object.Foo
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "simple object with no args" <|
            \() ->
                { name = "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "RootQuery"
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder droid RootQuery
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity)
"""
        , test "simple object with no args for object" <|
            \() ->
                { name = "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder droid Api.Object.Foo
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity)
"""
        , test "list of objects with no args" <|
            \() ->
                { name = "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable)) Type.NonNullable
                , args = []
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet droid Api.Object.Droid -> FieldDecoder (List droid) Api.Object.Foo
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity >> Decode.list)
"""
        , test "with required args" <|
            \() ->
                { name = "human"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Human") Type.NonNullable
                , args =
                    [ { name = "id"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "RootQuery"
                    |> Expect.equal
                        """human : { id : String } -> SelectionSet human Api.Object.Human -> FieldDecoder human RootQuery
human requiredArgs object =
      Object.selectionFieldDecoder "human" [ Argument.required "id" requiredArgs.id (Encode.string) ] (object) (identity)
"""
        , test "with optional args" <|
            \() ->
                { name = "menuItems"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable)) Type.NonNullable
                , args =
                    [ { name = "contains"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "RootQuery"
                    |> Expect.equal
                        """menuItems : ({ contains : OptionalArgument String } -> { contains : OptionalArgument String }) -> SelectionSet menuItems Api.Object.MenuItem -> FieldDecoder (List menuItems) RootQuery
menuItems fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { contains = Absent }

        optionalArgs =
            [ Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
                |> List.filterMap identity
    in
      Object.selectionFieldDecoder "menuItems" optionalArgs (object) (identity >> Decode.list)
"""
        , test "normalizes reserved names" <|
            \() ->
                { name = "type"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                , args = []
                }
                    |> Field.generate [ "Api" ] { query = "RootQuery", mutation = Nothing } "TreeEntry"
                    |> Expect.equal
                        """type_ : FieldDecoder String Api.Object.TreeEntry
type_ =
      Object.fieldDecoder "type" [] (Decode.string)
"""
        ]


captainsField : Type.Field
captainsField =
    { name = "captains"
    , description = Nothing
    , typeRef =
        Type.TypeReference
            (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
            Type.NonNullable
    , args = []
    }


menuItemsField : Type.Field
menuItemsField =
    { name = "menuItems"
    , description = Nothing
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
    , description = Nothing
    , typeRef = Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable
    , args = []
    }


meField : Type.Field
meField =
    { name = "me"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
