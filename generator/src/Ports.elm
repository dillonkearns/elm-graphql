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
    , outputPath : String
    , baseModule : List String
    , customDecodersModule : Maybe String
    }
    -> Cmd msg


port introspectSchemaFromUrl :
    { excludeDeprecated : Bool
    , queryFile : Maybe String
    , graphqlUrl : String
    , baseModule : List String
    , outputPath : String
    , headers : Json.Encode.Value
    , customDecodersModule : Maybe String
    }
    -> Cmd msg


port generateFiles : ({ queryFile: Maybe String, introspectionData: Json.Encode.Value } -> msg) -> Sub msg


port generatedFiles : Json.Encode.Value -> Cmd msg
