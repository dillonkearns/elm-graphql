module Helpers exposing (expectField)

import Graphqelm.Field as Field exposing (Field)


expectField : Field (Maybe a) typeLock -> Field a typeLock
expectField =
    Field.map expect


expect : Maybe a -> a
expect maybe =
    case maybe of
        Just thing ->
            thing

        Nothing ->
            Debug.crash "Expected to get thing, got nothing"
