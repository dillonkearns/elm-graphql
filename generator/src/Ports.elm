port module Ports exposing (generateFiles, introspectSchemaFromFile, introspectSchemaFromUrl, print, printAndExitFailure, printAndExitSuccess)

import Json.Encode


port print : String -> Cmd msg


port printAndExitFailure : String -> Cmd msg


port printAndExitSuccess : String -> Cmd msg


port introspectSchemaFromFile : String -> Cmd msg


port introspectSchemaFromUrl : { excludeDeprecated : Bool, graphqlUrl : String } -> Cmd msg


port generateFiles : (Json.Encode.Value -> msg) -> Sub msg
