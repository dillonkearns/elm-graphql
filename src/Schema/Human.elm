module Schema.Human exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field)


human : { id : String } -> List Argument -> List Field -> Field
human requiredArgs optionalArgs children =
    Field.Composite "human" ([ id requiredArgs.id ] ++ optionalArgs) children


id : String -> Argument
id value =
    Argument.string "id" value


name : Field
name =
    Field.string "name"


height : List Argument -> List Field -> Field
height params children =
    Field.int "height"
