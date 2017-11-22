module Schema.Human exposing (..)

import GraphqElm.Field as Field exposing (Field)
import GraphqElm.Param as Param exposing (Param)


human : List Param -> List Field -> number
human parameters children =
    Debug.crash "Unimplemented"


id : String -> Param
id value =
    Param.string "id" value


name : Field
name =
    Field.string "name"
