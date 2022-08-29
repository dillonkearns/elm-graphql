module Generator.FieldTests exposing (all)

import Dict
import Expect
import Graphql.Generator.Context as Context exposing (Context, stub)
import Graphql.Generator.Field as Field
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.Parser.Scalar as Scalar exposing (Scalar)
import Graphql.Parser.Type as Type exposing (TypeDefinition, TypeReference)
import Test exposing (..)


contextWith : Maybe (Dict.Dict String (List TypeDefinition)) -> Context
contextWith maybeInterfaceLookup =
    -- Context.stub
    { stub
        | query = "RootQueryObject" |> ClassCaseName.build
        , apiSubmodule = [ "Api" ]
        , interfaces = maybeInterfaceLookup |> Maybe.withDefault Dict.empty
    }


typeDefinition : Maybe (Dict.Dict String (List TypeDefinition))
typeDefinition =
    Just <|
        Dict.fromList
            [ ( "Character"
              , [ Type.typeDefinition "Human" (Type.ObjectType [] []) Nothing
                , Type.typeDefinition "Droid" (Type.ObjectType [] []) Nothing
                ]
              )
            ]


all : Test
all =
    describe "field generator"
        [ test "simple scalar converts for query" <|
            \() ->
                meField
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "RootQueryObject")
                    |> Expect.equal
                        """me : SelectionSet String RootQuery
me =
      Object.selectionForField "String" "me" [] (Decode.string)
"""
        , test "converts for object" <|
            \() ->
                meField
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "Foo")
                    |> Expect.equal
                        """me : SelectionSet String Api.Object.Foo
me =
      Object.selectionForField "String" "me" [] (Decode.string)
"""
        , test "simple object with no args" <|
            \() ->
                { name = CamelCaseName.build "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "RootQueryObject")
                    |> Expect.equal
                        """droid : SelectionSet decodesTo Api.Object.Droid
 -> SelectionSet decodesTo RootQuery
droid object____ =
      Object.selectionForCompositeField "droid" [] (object____) (Basics.identity)
"""
        , test "simple interface with no args" <|
            \() ->
                { name = CamelCaseName.build "hero"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.InterfaceRef "Character") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject
                        (contextWith typeDefinition)
                        (ClassCaseName.build "RootQueryObject")
                    |> Expect.equal
                        """hero : SelectionSet decodesTo Api.Interface.Character
 -> SelectionSet decodesTo RootQuery
hero object____ =
      Object.selectionForCompositeField "hero" [] (object____) (Basics.identity)
"""
        , test "simple object with no args for object" <|
            \() ->
                { name = CamelCaseName.build "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "Foo")
                    |> Expect.equal
                        """droid : SelectionSet decodesTo Api.Object.Droid
 -> SelectionSet decodesTo Api.Object.Foo
droid object____ =
      Object.selectionForCompositeField "droid" [] (object____) (Basics.identity)
"""
        , test "list of objects with no args" <|
            \() ->
                { name = CamelCaseName.build "droid"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "Droid") Type.NonNullable)) Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "Foo")
                    |> Expect.equal
                        """droid : SelectionSet decodesTo Api.Object.Droid
 -> SelectionSet (List decodesTo) Api.Object.Foo
droid object____ =
      Object.selectionForCompositeField "droid" [] (object____) (Basics.identity >> Decode.list)
"""
        , test "with required args" <|
            \() ->
                { name = CamelCaseName.build "human"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.ObjectRef "Human") Type.NonNullable
                , args =
                    [ { name = CamelCaseName.build "id"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                      }
                    ]
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "RootQueryObject")
                    |> Expect.equal
                        """type alias HumanRequiredArguments = { id : String }

human : HumanRequiredArguments
 -> SelectionSet decodesTo Api.Object.Human
 -> SelectionSet decodesTo RootQuery
human requiredArgs____ object____ =
      Object.selectionForCompositeField "human" [ Argument.required "id" requiredArgs____.id (Encode.string) ] (object____) (Basics.identity)
"""
        , test "with optional args" <|
            \() ->
                { name = CamelCaseName.build "menuItems"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.List (Type.TypeReference (Type.ObjectRef "MenuItem") Type.NonNullable)) Type.NonNullable
                , args =
                    [ { name = CamelCaseName.build "contains"
                      , description = Nothing
                      , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                      }
                    ]
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "RootQueryObject")
                    |> Expect.equal
                        """type alias MenuItemsOptionalArguments = { contains : OptionalArgument String }

menuItems : (MenuItemsOptionalArguments -> MenuItemsOptionalArguments)
 -> SelectionSet decodesTo Api.Object.MenuItem
 -> SelectionSet (List decodesTo) RootQuery
menuItems fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { contains = Absent }

        optionalArgs____ =
            [ Argument.optional "contains" filledInOptionals____.contains (Encode.string) ]
                |> List.filterMap Basics.identity
    in
      Object.selectionForCompositeField "menuItems" optionalArgs____ (object____) (Basics.identity >> Decode.list)
"""
        , test "normalizes reserved names" <|
            \() ->
                { name = CamelCaseName.build "type"
                , description = Nothing
                , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                , args = []
                }
                    |> Field.generateForObject (contextWith Nothing) (ClassCaseName.build "TreeEntry")
                    |> Expect.equal
                        """type_ : SelectionSet String Api.Object.TreeEntry
type_ =
      Object.selectionForField "String" "type" [] (Decode.string)
"""
        ]


meField : Type.Field
meField =
    { name = CamelCaseName.build "me"
    , description = Nothing
    , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
    , args = []
    }
