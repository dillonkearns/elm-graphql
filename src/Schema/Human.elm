module Schema.Human exposing (..)

import GraphqElm.Field as Field exposing (Argument, Field)
import GraphqElm.Param as Param exposing (Param)


human : List Argument -> List Field -> Field
human args children =
    Field.Composite "human" args children


id : String -> Param
id value =
    Param.string "id" value


name : Field
name =
    Field.string "name"


height : List Param -> List Field -> Field
height params children =
    Field.int "height"
