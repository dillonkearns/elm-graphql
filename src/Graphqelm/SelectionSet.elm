module Graphqelm.SelectionSet exposing (PolymorphicSelectionSet(PolymorphicSelectionSet), SelectionSet(SelectionSet), add, combine, empty, singleton, with)

{-| The auto-generated code from the `graphqelm` CLI will provide `selection`
functions for Objects in your GraphQL schema. These functions take a `Graphqelm.SelectionSet`
which describes which fields to retrieve on that SelectionSet.
@docs SelectionSet, with, combine, PolymorphicSelectionSet, singleton, add, empty
-}

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)
import List.Extra


{-| TODO
-}
combine :
    ( String, SelectionSet union typeLock )
    -> ( String, SelectionSet union typeLockB )
    -> PolymorphicSelectionSet union
combine ( fragmentOnTypeA, SelectionSet fieldsA decoderA ) ( fragmentOnTypeB, SelectionSet fieldsB decoderB ) =
    PolymorphicSelectionSet
        [ { fragmentOnType = fragmentOnTypeA, selection = fieldsA }
        , { fragmentOnType = fragmentOnTypeB, selection = fieldsB }
        ]
        (Decode.field "__typename" Decode.string
            |> Decode.andThen
                (\typename ->
                    if typename == fragmentOnTypeA then
                        decoderA
                    else
                        decoderB
                )
        )


{-| TODO
-}
add :
    ( String, SelectionSet union typeLockA )
    -> PolymorphicSelectionSet union
    -> PolymorphicSelectionSet union
add ( fragmentOnTypeA, SelectionSet fieldsA decoderA ) (PolymorphicSelectionSet list decoder) =
    PolymorphicSelectionSet
        ({ fragmentOnType = fragmentOnTypeA, selection = fieldsA }
            :: list
        )
        (Decode.field "__typename" Decode.string
            |> Decode.andThen
                (\typename ->
                    if typename == fragmentOnTypeA then
                        decoderA
                    else
                        decoder
                )
        )


{-| TODO
-}
singleton :
    ( String, SelectionSet union typeLockA )
    -> PolymorphicSelectionSet union
singleton ( fragmentOnTypeA, SelectionSet fieldsA decoderA ) =
    PolymorphicSelectionSet
        [ { fragmentOnType = fragmentOnTypeA, selection = fieldsA } ]
        (Decode.field "__typename" Decode.string
            |> Decode.andThen
                (\typename ->
                    if typename == fragmentOnTypeA then
                        decoderA
                    else
                        Decode.fail ("Unexpected type " ++ typename)
                )
        )


{-| SelectionSet type
-}
type SelectionSet decodesTo typeLock
    = SelectionSet (List Field) (Decoder decodesTo)


{-| A SelectionSet that has no fields and always decodes to the hardcoded value provided.
-}
empty : value -> SelectionSet value typeLock
empty value =
    SelectionSet [] (Decode.succeed value)


{-| PolymorphicSelectionSet type
-}
type PolymorphicSelectionSet decodesTo
    = PolymorphicSelectionSet (List { fragmentOnType : String, selection : List Field }) (Decoder decodesTo)


{-| Used to pick out fields on an object.

    import Api.Enum.Episode as Episode exposing (Episode)
    import Api.Object
    import Graphqelm.SelectionSet exposing (SelectionSet, with)

    type alias Hero =
        { name : String
        , id : String
        , appearsIn : List Episode
        }

    hero : SelectionSet Hero Api.Object.Character
    hero =
        Character.selection Hero
            |> with Character.name
            |> with Character.id
            |> with Character.appearsIn

-}
with : FieldDecoder a typeLock -> SelectionSet (a -> b) typeLock -> SelectionSet b typeLock
with (FieldDecoder field fieldDecoder) (SelectionSet objectFields objectDecoder) =
    let
        n =
            List.length objectFields

        fieldName =
            Field.name field

        duplicateCount =
            List.Extra.count (\current -> fieldName == Field.name current) objectFields

        decodeFieldName =
            if duplicateCount > 0 then
                fieldName ++ toString (duplicateCount + 1)
            else
                fieldName
    in
    SelectionSet (objectFields ++ [ field ])
        (Decode.map2 (|>)
            (Decode.field decodeFieldName fieldDecoder)
            objectDecoder
        )
