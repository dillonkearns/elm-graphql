module Helpers exposing (expectField)

import Graphql.Field as Field exposing (Field)


expectField : Field (Maybe a) typeLock -> Field a typeLock
expectField =
    Field.map expect


expect : Maybe a -> a
expect maybe =
    case maybe of
        Just thing ->
            thing

        Nothing ->
            Debug.todo "Expected to get thing, got nothing"
