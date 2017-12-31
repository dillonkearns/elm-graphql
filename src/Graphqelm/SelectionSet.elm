module Graphqelm.SelectionSet exposing (PolymorphicSelectionSet(PolymorphicSelectionSet), SelectionSet(SelectionSet), add, ignore, singleton, with, withBase)

{-| The auto-generated code from the `graphqelm` CLI will provide `selection`
functions for Objects in your GraphQL schema. These functions take a `Graphqelm.SelectionSet`
which describes which fields to retrieve on that SelectionSet.
@docs SelectionSet, with, PolymorphicSelectionSet, singleton, add, ignore, withBase
-}

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)
import List.Extra


{-| TODO
-}
add :
    ( String, SelectionSet union typeLockA )
    -> PolymorphicSelectionSet union
    -> PolymorphicSelectionSet union
add ( fragmentOnTypeA, SelectionSet fieldsA decoderA ) (PolymorphicSelectionSet base list decoder) =
    PolymorphicSelectionSet
        base
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
withBase :
    SelectionSet base typeLockA
    -> PolymorphicSelectionSet union
    -> PolymorphicSelectionSet ( base, union )
withBase (SelectionSet fieldsBase decoderBase) (PolymorphicSelectionSet base list decoder) =
    PolymorphicSelectionSet
        { baseFields = fieldsBase }
        list
        (Decode.map2 (,) decoderBase decoder)


{-| TODO
-}
singleton :
    ( String, SelectionSet union typeLockA )
    -> PolymorphicSelectionSet union
singleton ( fragmentOnTypeA, SelectionSet fieldsA decoderA ) =
    PolymorphicSelectionSet
        { baseFields = [] }
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
ignore : value -> SelectionSet value typeLock
ignore value =
    SelectionSet [] (Decode.succeed value)


{-| PolymorphicSelectionSet type
-}
type PolymorphicSelectionSet decodesTo
    = PolymorphicSelectionSet { baseFields : List Field } (List { fragmentOnType : String, selection : List Field }) (Decoder decodesTo)


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
