module GraphqElm.Generator.Group exposing (Group, gather)

import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)


type alias Group =
    { queries : List Field
    , scalars : List TypeDefinition
    , objects : List TypeDefinition
    , enums : List TypeDefinition
    }


gather : List TypeDefinition -> Group
gather definitions =
    definitions
        |> List.foldl addToGroup
            { queries = []
            , scalars = []
            , objects = []
            , enums = []
            }


addToGroup : TypeDefinition -> Group -> Group
addToGroup ((Type.TypeDefinition name definableType) as definition) group =
    if String.startsWith "__" name then
        group
    else
        case definableType of
            Type.ObjectType fields ->
                if name == "RootQueryType" then
                    { group | queries = fields }
                else
                    { group | objects = definition :: group.objects }

            definableType ->
                group
