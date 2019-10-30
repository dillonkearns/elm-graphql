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
    , queryDirectory : Maybe String
    , baseModule : List String
    , customDecodersModule : Maybe String
    }
    -> Cmd msg


port introspectSchemaFromUrl :
    { excludeDeprecated : Bool
    , queryDirectory : Maybe String
    , graphqlUrl : String
    , baseModule : List String
    , outputPath : String
    , headers : Json.Encode.Value
    , customDecodersModule : Maybe String
    }
    -> Cmd msg


port generateFiles : ({ queryFiles: Json.Encode.Value, introspectionData: Json.Encode.Value } -> msg) -> Sub msg


port generatedFiles : Json.Encode.Value -> Cmd msg
