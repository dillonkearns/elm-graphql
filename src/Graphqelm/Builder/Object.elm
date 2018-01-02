module Graphqelm.Builder.Object exposing (fieldDecoder, object, polymorphicObject, polymorphicSelectionDecoder, selectionFieldDecoder)

{-| Internal functions for use by auto-generated code from the `graphqelm` CLI.
@docs fieldDecoder, object, selectionFieldDecoder, polymorphicSelectionDecoder, polymorphicObject
-}

import Dict
import Graphqelm.Builder.Argument exposing (Argument)
import Graphqelm.Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), PolymorphicSelectionSet(PolymorphicSelectionSet), SelectionSet(..))
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


{-| Refer to a polymorphic object in auto-generated code.
-}
polymorphicSelectionDecoder :
    String
    -> List Argument
    -> PolymorphicSelectionSet a
    -> (Decoder a -> Decoder b)
    -> FieldDecoder b lockedTo
polymorphicSelectionDecoder fieldName args (PolymorphicSelectionSet base fragments decoder) decoderTransform =
    let
        fields =
            List.map (\{ fragmentOnType, selection } -> composite ("...on " ++ fragmentOnType) [] selection) fragments
    in
    FieldDecoder (composite fieldName args ((typename :: fields) ++ base.baseFields)) (decoderTransform decoder)


typename : Field
typename =
    leaf "__typename" []


composite : String -> List Argument -> List Field -> Field
composite fieldName args fields =
    Graphqelm.Field.Composite fieldName args fields


leaf : String -> List Argument -> Field
leaf fieldName args =
    Graphqelm.Field.Leaf fieldName args


{-| Used to create the `selection` functions in auto-generated code.
-}
object : (a -> constructor) -> SelectionSet (a -> constructor) typeLock
object constructor =
    SelectionSet [] (Decode.succeed constructor)


{-| Used to create the `selection` functions in auto-generated code for interfaces and unions.
-}
polymorphicObject : List (FragmentSelectionSet typeSpecific typeLock) -> (Maybe typeSpecific -> a -> b) -> SelectionSet (a -> b) typeLock
polymorphicObject typeSpecificSelections constructor =
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



{-
           let
       fields =
           List.map (\{ fragmentOnType, selection } -> composite ("...on " ++ fragmentOnType) [] selection) fragments
   in
   FieldDecoder (composite fieldName args ((typename :: fields) ++ base.baseFields)) (decoderTransform decoder)

-}
