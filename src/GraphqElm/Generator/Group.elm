module GraphqElm.Generator.Group exposing (IntrospectionData, generateFiles)

import Dict exposing (Dict)
import GraphqElm.Generator.Enum
import GraphqElm.Generator.Object
import GraphqElm.Generator.Query
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)


type alias IntrospectionData =
    { typeDefinitions : List TypeDefinition
    , queryObjectName : String
    }


generateFiles : IntrospectionData -> Dict String String
generateFiles { typeDefinitions, queryObjectName } =
    typeDefinitions
        |> List.filterMap (toPair queryObjectName)
        |> List.map (Tuple.mapFirst moduleToFileName)
        |> Dict.fromList


moduleToFileName : List String -> String
moduleToFileName modulePath =
    (modulePath |> String.join "/")
        ++ ".elm"


toPair : String -> TypeDefinition -> Maybe ( List String, String )
toPair queryObjectName ((Type.TypeDefinition name definableType) as definition) =
    if String.startsWith "__" name then
        Nothing
    else
        case definableType of
            Type.ObjectType fields ->
                if name == queryObjectName then
                    GraphqElm.Generator.Query.generate fields
                        |> Just
                else
                    GraphqElm.Generator.Object.generate name fields
                        |> Just

            Type.ScalarType ->
                Nothing

            Type.EnumType enumValues ->
                GraphqElm.Generator.Enum.generate name enumValues
                    |> Just

            Type.InterfaceType fields ->
                GraphqElm.Generator.Object.generate name fields
                    |> Just
