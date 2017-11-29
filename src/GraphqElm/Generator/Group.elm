module GraphqElm.Generator.Group exposing (Group, gather, generateFiles)

import Dict exposing (Dict)
import GraphqElm.Generator.Object
import GraphqElm.Generator.Query
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


generateFiles : List TypeDefinition -> Dict String String
generateFiles typeDefinitions =
    typeDefinitions
        |> List.filterMap toPair
        |> List.map (Tuple.mapFirst moduleToFileName)
        |> Dict.fromList


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : TypeDefinition -> Maybe ( List String, String )
toPair ((Type.TypeDefinition name definableType) as definition) =
    if String.startsWith "__" name then
        Nothing
    else
        case definableType of
            Type.ObjectType fields ->
                if name == "RootQueryType" then
                    GraphqElm.Generator.Query.generateNewFormat fields
                        |> Just
                else
                    GraphqElm.Generator.Object.generateNewFormat name fields
                        |> Just

            definableType ->
                Nothing


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
