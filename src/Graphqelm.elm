module Graphqelm exposing (map, map2, map3, noOptionalArgs)

import Graphqelm.Field
import Graphqelm.Object as Object exposing (Object)


noOptionalArgs : a -> a
noOptionalArgs =
    identity


map :
    (placeholder -> Object (a -> result) typeLock)
    -> placeholder
    -> Graphqelm.Field.FieldDecoder a typeLock
    -> Object result typeLock
map build buildTo a =
    build buildTo
        |> Object.with a


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


map3 :
    (placeholder -> Object (a -> b -> c -> result) typeLock)
    -> placeholder
    -> Graphqelm.Field.FieldDecoder a typeLock
    -> Graphqelm.Field.FieldDecoder b typeLock
    -> Graphqelm.Field.FieldDecoder c typeLock
    -> Object result typeLock
map3 build buildTo a b c =
    build buildTo
        |> Object.with a
        |> Object.with b
        |> Object.with c
