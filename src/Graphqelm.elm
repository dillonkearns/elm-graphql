module Graphqelm exposing (RootMutation, RootQuery)

{-|


## Top-Level Types

@docs RootMutation, RootQuery

-}


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
