module Graphqelm exposing (RootMutation, RootQuery, map, map2, map3, noOptionalArgs)

{-|


## Optional Args

@docs noOptionalArgs


## Alternative Map syntax

@docs map, map2, map3


## Top-Level Types

@docs RootMutation, RootQuery

-}

import Graphqelm.Field
import Graphqelm.Object as Object exposing (Object)


{-| Type for top-level queries which can be sent using functions
from `Graphqelm.Http`.
-}
type RootQuery
    = RootQuery


{-| Type for top-level mutations which can be sent using functions
from `Graphqelm.Http`.
-}
type RootMutation
    = RootMutation


{-| TODO
-}
noOptionalArgs : a -> a
noOptionalArgs =
    identity


{-| TODO
-}
map :
    (placeholder -> Object (a -> result) typeLock)
    -> placeholder
    -> Graphqelm.Field.FieldDecoder a typeLock
    -> Object result typeLock
map build buildTo a =
    build buildTo
        |> Object.with a


{-| TODO
-}
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


{-| TODO
-}
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
