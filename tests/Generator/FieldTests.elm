module Generator.FieldTests exposing (..)

import Dict
import Expect
import Graphqelm.Generator.Context exposing (Context)
import Graphqelm.Generator.Field as Field
import Graphqelm.Parser.FieldName as FieldName
import Graphqelm.Parser.Scalar as Scalar exposing (Scalar)
import Graphqelm.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


context : String -> Context
context queryName =
    { query = "RootQueryObject", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty }


all : Test
all =
    describe "field generator"
        [ test "simple scalar converts for query" <|
            \() ->
                meField
                    |> Field.generateForObject { query = "RootQueryObject", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "RootQueryObject"
                    |> Expect.equal
                        """me : FieldDecoder String RootQuery
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "converts for object" <|
            \() ->
                meField
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "Foo"
                    |> Expect.equal
                        """me : FieldDecoder String Api.Object.Foo
me =
      Object.fieldDecoder "me" [] (Decode.string)
"""
        , test "simple object with no args" <|
            \() ->
                { name = FieldName.fieldName "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "RootQuery"
                    |> Expect.equal
                        """droid : SelectionSet selection Api.Object.Droid -> FieldDecoder selection RootQuery
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity)
"""
        , test "simple interface with no args" <|
            \() ->
                { name = FieldName.fieldName "hero"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.InterfaceRef "Character") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject
                        { query = "RootQuery"
                        , mutation = Nothing
                        , apiSubmodule = [ "Swapi" ]
                        , interfaces =
                            Dict.fromList
                                [ ( "Character", [ "Human", "Droid" ] )
                                ]
                        }
                        "RootQuery"
                    |> Expect.equal
                        """hero : SelectionSet selection Swapi.Interface.Character -> FieldDecoder selection RootQuery
hero object =
      Object.selectionFieldDecoder "hero" [] (object) (identity)
"""
        , test "simple object with no args for object" <|
            \() ->
                { name = FieldName.fieldName "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet selection Api.Object.Droid -> FieldDecoder selection Api.Object.Foo
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity)
"""
        , test "list of objects with no args" <|
            \() ->
                { name = FieldName.fieldName "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable)) Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "Foo"
                    |> Expect.equal
                        """droid : SelectionSet selection Api.Object.Droid -> FieldDecoder (List selection) Api.Object.Foo
droid object =
      Object.selectionFieldDecoder "droid" [] (object) (identity >> Decode.list)
"""
        , test "with required args" <|
            \() ->
                { name = FieldName.fieldName "human"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Human") Type.NonNullable
                , args =
                    [ { name = "id"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "RootQuery"
                    |> Expect.equal
                        """human : { id : String } -> SelectionSet selection Api.Object.Human -> FieldDecoder selection RootQuery
human requiredArgs object =
      Object.selectionFieldDecoder "human" [ Argument.required "id" requiredArgs.id (Encode.string) ] (object) (identity)
"""
        , test "with optional args" <|
            \() ->
                { name = FieldName.fieldName "menuItems"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable)) Type.NonNullable
                , args =
                    [ { name = "contains"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "RootQuery"
                    |> Expect.equal
                        """menuItems : ({ contains : OptionalArgument String } -> { contains : OptionalArgument String }) -> SelectionSet selection Api.Object.MenuItem -> FieldDecoder (List selection) RootQuery
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
                { name = FieldName.fieldName "type"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject { query = "RootQuery", mutation = Nothing, apiSubmodule = [ "Api" ], interfaces = Dict.empty } "TreeEntry"
                    |> Expect.equal
                        """type_ : FieldDecoder String Api.Object.TreeEntry
type_ =
      Object.fieldDecoder "type" [] (Decode.string)
"""
        ]


captainsField : Type.Field
captainsField =
    { name = FieldName.fieldName "captains"
    , description = Nothing
    , typeRef =
        Type.TypeReference
            (Type.List (Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable))
            Type.NonNullable
    , args = []
    }


menuItemsField : Type.Field
menuItemsField =
    { name = FieldName.fieldName "menuItems"
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
    { name = FieldName.fieldName "menuItem"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable
    , args = []
    }


meField : Type.Field
meField =
    { name = FieldName.fieldName "me"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
