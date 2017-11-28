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
    let
        something =
            definitions |> List.filter (\(Type.TypeDefinition name _) -> name == "RootQueryType")
    in
    case something of
        [ Type.TypeDefinition name (Type.ObjectType fields) ] ->
            { queries = fields
            , scalars = []
            , objects = []
            , enums = []
            }

        _ ->
            { queries = []
            , scalars = []
            , objects = []
            , enums = []
            }
