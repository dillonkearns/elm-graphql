module Graphqelm.OptionalArgument exposing (OptionalArgument(..))


type OptionalArgument a
    = Present a
    | Absent
    | Null
