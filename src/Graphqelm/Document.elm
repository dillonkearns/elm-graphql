module Graphqelm.Document exposing (RootMutation, RootQuery)

{-| Types used by generated code to annotate the top-level query
and mutation objects in your API.
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
