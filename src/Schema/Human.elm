module Schema.Human exposing (..)

import GraphqElm.Argument as Argument exposing (Argument)
import GraphqElm.Field as Field exposing (Field, FieldDecoder)


type alias Human =
    { name : String }


human : { id : String } -> List Argument -> FieldDecoder (String -> Human)
human requiredArgs optionalArgs =
    Field.object Human
        "human"
        ([ id requiredArgs.id ] ++ optionalArgs)


id : String -> Argument
id value =
    Argument.string "id" value


name : FieldDecoder String
name =
    Field.string "name"
