module Graphqelm.Internal.Builder.Object exposing (fieldDecoder, interfaceSelection, selection, selectionFieldDecoder, unionSelection)

{-| **WARNING** `Graphqelm.Interal` modules are used by the `graphqelm` command line
code generator tool. They should not be consumed through hand-written code.

Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs fieldDecoder, selection, selectionFieldDecoder, interfaceSelection, unionSelection

-}

import Dict
import Graphqelm.Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Graphqelm.Internal.Builder.Argument exposing (Argument)
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(..))
import Json.Decode as Decode exposing (Decoder)


{-| Refer to a field in auto-generated code.
-}
fieldDecoder : String -> List Argument -> Decoder decodesTo -> FieldDecoder decodesTo lockedTo
fieldDecoder fieldName args decoder =
    FieldDecoder (leaf fieldName args) decoder


{-| Refer to an object in auto-generated code.
-}
selectionFieldDecoder :
    String
    -> List Argument
    -> SelectionSet a objectTypeLock
    -> (Decoder a -> Decoder b)
    -> FieldDecoder b lockedTo
selectionFieldDecoder fieldName args (SelectionSet fields decoder) decoderTransform =
    FieldDecoder (composite fieldName args fields) (decoderTransform decoder)


composite : String -> List Argument -> List Field -> Field
composite fieldName args fields =
    Graphqelm.Field.Composite fieldName args fields


leaf : String -> List Argument -> Field
leaf fieldName args =
    Graphqelm.Field.Leaf fieldName args


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
