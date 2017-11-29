module GraphqElm.Generator.Group exposing (generateFiles)

import Dict exposing (Dict)
import GraphqElm.Generator.Object
import GraphqElm.Generator.Query
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)


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
                    GraphqElm.Generator.Query.generate fields
                        |> Just
                else
                    GraphqElm.Generator.Object.generate name fields
                        |> Just

            Type.ScalarType _ ->
                Nothing
