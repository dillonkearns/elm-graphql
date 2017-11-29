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
addToGroup definition group =
    case definition of
        Type.TypeDefinition "RootQueryType" (Type.ObjectType fields) ->
            { group | queries = fields }

        Type.TypeDefinition name (Type.ObjectType fields) ->
            { group | objects = definition :: group.objects }

        Type.TypeDefinition name definableType ->
            group
