module GraphqElm.Generator.Group exposing (Group, gather)

import GraphqElm.Parser exposing (Field)


type alias Group =
    { queries : List Field
    , scalars : List Field
    , objects : List Field
    , enums : List Field
    }


gather : List Field -> Group
gather fields =
    { queries = fields
    , scalars = []
    , objects = []
    , enums = []
    }
