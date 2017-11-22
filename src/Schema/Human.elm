module Schema.Human exposing (..)

import GraphqElm.Field as Field exposing (Field)
import GraphqElm.Param as Param exposing (Param)


human : List Param -> List Field -> Field
human params children =
    Debug.crash "Unimplemented"


id : String -> Param
id value =
    Param.string "id" value


name : Field String
name =
    Field.string "name"


height : List Param -> List Field -> Field Int
height params children =
    Field.int "height"
