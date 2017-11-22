module GraphqElm.Field exposing (..)


type Field
    = Field String


string : String -> Field
string fieldName =
    Field fieldName
