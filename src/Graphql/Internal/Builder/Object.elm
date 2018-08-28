module Graphql.Internal.Builder.Object exposing (fieldDecoder, selection, selectionField, interfaceSelection, unionSelection, scalarDecoder)

{-| **WARNING** `Graphql.Interal` modules are used by the `@dillonkearns/elm-graphql` command line
code generator tool. They should not be consumed through hand-written code.

Internal functions for use by auto-generated code from the `@dillonkearns/elm-graphql` CLI.

@docs fieldDecoder, selection, selectionField, interfaceSelection, unionSelection, scalarDecoder

-}

import Dict
import Graphql.Field as Field exposing (Field(..))
import Graphql.Internal.Builder.Argument exposing (Argument)
import Graphql.RawField exposing (RawField)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Json.Decode as Decode exposing (Decoder)


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
                    case bool of
                        True ->
                            "true"

                        False ->
                            "false"
                )
        ]


{-| Refer to a field in auto-generated code.
-}
fieldDecoder : String -> List Argument -> Decoder decodesTo -> Field decodesTo lockedTo
fieldDecoder fieldName args decoder =
    Field (leaf fieldName args) decoder


{-| Refer to an object in auto-generated code.
-}
selectionField :
    String
    -> List Argument
    -> SelectionSet a objectTypeLock
    -> (Decoder a -> Decoder b)
    -> Field b lockedTo
selectionField fieldName args (SelectionSet fields decoder) decoderTransform =
    Field (composite fieldName args fields) (decoderTransform decoder)


composite : String -> List Argument -> List RawField -> RawField
composite fieldName args fields =
    Graphql.RawField.Composite fieldName args fields


leaf : String -> List Argument -> RawField
leaf fieldName args =
    Graphql.RawField.Leaf fieldName args


{-| Used to create the `selection` functions in auto-generated code.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) typeLock
selection constructor =
    SelectionSet [] (Decode.succeed constructor)


{-| Used to create the `selection` functions in auto-generated code for interfaces.
-}
interfaceSelection : List (FragmentSelectionSet typeSpecific typeLock) -> (Maybe typeSpecific -> a -> b) -> SelectionSet (a -> b) typeLock
interfaceSelection typeSpecificSelections constructor =
    let
        typeNameDecoder =
            \typeName ->
                typeSpecificSelections
                    |> List.map (\(FragmentSelectionSet thisTypeName fields decoder) -> ( thisTypeName, decoder ))
                    |> Dict.fromList
                    |> Dict.get typeName
                    |> Maybe.map (Decode.map Just)
                    |> Maybe.withDefault (Decode.succeed Nothing)

        selections =
            typeSpecificSelections
                |> List.map (\(FragmentSelectionSet typeName fields decoder) -> composite ("...on " ++ typeName) [] fields)
    in
    SelectionSet (leaf "__typename" [] :: selections)
        (Decode.map2 (|>)
            (Decode.string
                |> Decode.field "__typename"
                |> Decode.andThen typeNameDecoder
            )
            (Decode.succeed constructor)
        )


{-| Used to create the `selection` functions in auto-generated code for unions.
-}
unionSelection : List (FragmentSelectionSet typeSpecific typeLock) -> (Maybe typeSpecific -> a) -> SelectionSet a typeLock
unionSelection typeSpecificSelections constructor =
    let
        typeNameDecoder =
            \typeName ->
                typeSpecificSelections
                    |> List.map (\(FragmentSelectionSet thisTypeName fields decoder) -> ( thisTypeName, decoder ))
                    |> Dict.fromList
                    |> Dict.get typeName
                    |> Maybe.map (Decode.map Just)
                    |> Maybe.withDefault (Decode.succeed Nothing)

        selections =
            typeSpecificSelections
                |> List.map (\(FragmentSelectionSet typeName fields decoder) -> composite ("...on " ++ typeName) [] fields)
    in
    SelectionSet (leaf "__typename" [] :: selections)
        (Decode.map2 (|>)
            (Decode.string
                |> Decode.field "__typename"
                |> Decode.andThen typeNameDecoder
            )
            (Decode.succeed constructor)
        )
