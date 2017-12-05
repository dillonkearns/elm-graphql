module Graphqelm exposing (map2, noOptionalArgs)

import Graphqelm.Field
import Graphqelm.Object as Object exposing (Object)


noOptionalArgs : a -> a
noOptionalArgs =
    identity


map2 :
    (placeholder -> Object (a -> b -> result) typeLock)
    -> placeholder
    -> Graphqelm.Field.FieldDecoder a typeLock
    -> Graphqelm.Field.FieldDecoder b typeLock
    -> Object result typeLock
map2 build buildTo a b =
    build buildTo
        |> Object.with a
        |> Object.with b
