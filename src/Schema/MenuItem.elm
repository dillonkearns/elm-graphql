module Schema.MenuItem exposing (..)

import GraphqElm.Field as Field exposing (Field, FieldDecoder)


id : FieldDecoder String
id =
    Field.string "id"


name : FieldDecoder String
name =
    Field.string "name"
