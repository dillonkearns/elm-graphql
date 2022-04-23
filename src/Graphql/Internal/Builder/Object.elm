module Graphql.Internal.Builder.Object exposing (scalarDecoder, exhaustiveFragmentSelection, buildFragment, selectionForField, selectionForCompositeField)

{-| **WARNING** `Graphql.Internal` modules are used by the `@dillonkearns/elm-graphql` command line
code generator tool. They should not be consumed through hand-written code.

Internal functions for use by auto-generated code from the `@dillonkearns/elm-graphql` CLI.

@docs scalarDecoder, exhaustiveFragmentSelection, buildFragment, selectionForField, selectionForCompositeField

-}

import Dict
import Graphql.Document.Field
import Graphql.Internal.Builder.Argument exposing (Argument)
import Graphql.RawField exposing (RawField)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode exposing (Decoder)
import String.Interpolate exposing (interpolate)


{-| Decoder for scalars for use in auto-generated code.
-}
scalarDecoder : Decoder String
scalarDecoder =
    Decode.oneOf
        [ Decode.string
        , Decode.float |> Decode.map String.fromFloat
        , Decode.int |> Decode.map String.fromInt
        , Decode.bool
            |> Decode.map
                (\bool ->
                    if bool then
                        "true"

                    else
                        "false"
                )
        ]


{-| Refer to a field in auto-generated code.
-}
selectionForField : String -> String -> List Argument -> Decoder decodesTo -> SelectionSet decodesTo lockedTo
selectionForField typeString fieldName args decoder =
    let
        newLeaf =
            leaf { typeString = typeString, fieldName = fieldName } args
    in
    SelectionSet [ newLeaf ]
        (Decode.oneOf
            [ Decode.field fieldName decoder
            , Decode.field (Graphql.Document.Field.hashedAliasName newLeaf) decoder
            ]
        )


{-| Refer to an object in auto-generated code.
-}
selectionForCompositeField :
    String
    -> List Argument
    -> SelectionSet a objectScope
    -> (Decoder a -> Decoder b)
    -> SelectionSet b lockedTo
selectionForCompositeField fieldName args (SelectionSet fields decoder) decoderTransform =
    SelectionSet [ composite fieldName args fields ]
        (Decode.oneOf
            [ Decode.field fieldName (decoderTransform decoder)
            , Decode.field
                (Graphql.Document.Field.hashedAliasName (composite fieldName args fields))
                (decoderTransform decoder)
            ]
        )


composite : String -> List Argument -> List RawField -> RawField
composite fieldName args fields =
    Graphql.RawField.Composite fieldName args fields


leaf : { typeString : String, fieldName : String } -> List Argument -> RawField
leaf details args =
    Graphql.RawField.Leaf details args


{-| Used to create FragmentSelectionSets for type-specific fragments in auto-generated code.
-}
buildFragment : String -> SelectionSet decodesTo selectionLock -> FragmentSelectionSet decodesTo fragmentLock
buildFragment fragmentTypeName (SelectionSet fields decoder) =
    FragmentSelectionSet fragmentTypeName fields decoder


{-| Used to create the `selection` functions in auto-generated code for exhaustive fragments.
-}
exhaustiveFragmentSelection : List (FragmentSelectionSet decodesTo scope) -> SelectionSet decodesTo scope
exhaustiveFragmentSelection typeSpecificSelections =
    let
        selections =
            typeSpecificSelections
                |> List.map (\(FragmentSelectionSet typeName fields decoder) -> composite ("...on " ++ typeName) [] fields)
    in
    SelectionSet (Graphql.RawField.typename :: selections)
        (Decode.string
            |> Decode.field (Graphql.Document.Field.hashedAliasName Graphql.RawField.typename)
            |> Decode.andThen
                (\typeName ->
                    typeSpecificSelections
                        |> List.map (\(FragmentSelectionSet thisTypeName fields decoder) -> ( thisTypeName, decoder ))
                        |> Dict.fromList
                        |> Dict.get typeName
                        |> Maybe.withDefault (exhaustiveFailureMessage typeSpecificSelections typeName |> Decode.fail)
                )
        )


exhaustiveFailureMessage : List (FragmentSelectionSet decodesTo scope) -> String -> String
exhaustiveFailureMessage typeSpecificSelections typeName =
    interpolate
        "Unhandled type `{0}` in exhaustive fragment handling. The following types had handlers registered to handle them: [{1}]. This happens if you are parsing either a Union or Interface. Do you need to rerun the `@dillonkearns/elm-graphql` command line tool?"
        [ typeName, typeSpecificSelections |> List.map (\(FragmentSelectionSet fragmentType fields decoder) -> fragmentType) |> String.join ", " ]
