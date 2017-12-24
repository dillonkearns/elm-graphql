module Graphqelm.Object exposing (Object(Object), with)

{-| The auto-generated code from the `graphqelm` CLI will provide `selection`
functions for Objects in your GraphQL schema. These functions take a `Graphqelm.Object`
which describes which fields to retrieve on that Object.
@docs Object, with
-}

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder(FieldDecoder))
import Json.Decode as Decode exposing (Decoder)


{-| Object type
-}
type Object decodesTo typeLock
    = Object (List Field) (Decoder decodesTo)


{-| Used to pick out fields on an object.

    import Api.Enum.Episode as Episode exposing (Episode)
    import Api.Object
    import Graphqelm.Object exposing (Object, with)

    type alias Hero =
        { name : String
        , id : String
        , appearsIn : List Episode
        }

    hero : Object Hero Api.Object.Character
    hero =
        Character.selection Hero
            |> with Character.name
            |> with Character.id
            |> with Character.appearsIn

-}
with : FieldDecoder a typeLock -> Object (a -> b) typeLock -> Object b typeLock
with (FieldDecoder field fieldDecoder) (Object objectFields objectDecoder) =
    case field of
        Field.QueryField nestedField ->
            let
                n =
                    List.length objectFields
            in
            Object (objectFields ++ [ nestedField ])
                (Decode.map2 (|>)
                    (Decode.field ("result" ++ toString (n + 1)) fieldDecoder)
                    objectDecoder
                )

        _ ->
            Object (field :: objectFields) (Decode.map2 (|>) fieldDecoder objectDecoder)
