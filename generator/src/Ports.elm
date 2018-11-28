port module Ports exposing
    ( generateFiles
    , generatedFiles
    , introspectSchemaFromFile
    , introspectSchemaFromUrl
    , print
    , printAndExitFailure
    , printAndExitSuccess
    )

import Json.Encode


port print : String -> Cmd msg


port printAndExitFailure : String -> Cmd msg


port printAndExitSuccess : String -> Cmd msg


port introspectSchemaFromFile :
    { introspectionFilePath : String
    , excludeDeprecated : Bool
    , outputPath : String
    , baseModule : List String
    }
    -> Cmd msg


port introspectSchemaFromUrl :
    { excludeDeprecated : Bool
    , graphqlUrl : String
    , baseModule : List String
    , outputPath : String
    , headers : Json.Encode.Value
    }
    -> Cmd msg


port generateFiles : (Json.Encode.Value -> msg) -> Sub msg


port generatedFiles : Json.Encode.Value -> Cmd msg
