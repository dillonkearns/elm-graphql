module Graphqelm.SelectionSet exposing (SelectionSet(SelectionSet), with)

{-| The auto-generated code from the `graphqelm` CLI will provide `selection`
functions for Objects in your GraphQL schema. These functions take a `Graphqelm.SelectionSet`
which describes which fields to retrieve on that SelectionSet.
@docs SelectionSet, with
-}

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)


{-| SelectionSet type
-}
type SelectionSet decodesTo typeLock
    = SelectionSet (List Field) (Decoder decodesTo)


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
    in
    SelectionSet (objectFields ++ [ field ])
        (Decode.map2 (|>)
            (Decode.field ("result" ++ toString (n + 1)) fieldDecoder)
            objectDecoder
        )
