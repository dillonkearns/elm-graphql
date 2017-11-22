module Schema.User exposing (..)

import Graphqelm.Param as Param exposing (Param)


repository : List Param -> List Never -> number
repository parameters children =
    Debug.crash "Unimplemented"


last : Int -> Param
last value =
    Param.int "last" value


owner : String -> Param
owner value =
    Param.string "owner" value


name : String -> Param
name value =
    Param.string "name" value
