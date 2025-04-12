module Main exposing (run)

import BackendTask exposing (BackendTask, allowFatal)
import BackendTask.Custom
import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (OptionsParser, with)
import Cli.Program as Program
import Cli.Validate
import Dict exposing (Dict)
import FatalError exposing (FatalError)
import Graphql.Parser
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode
import ModuleName exposing (ModuleName(..))
import Pages.Script as Script exposing (Script)
import Result.Extra
import String.Interpolate exposing (interpolate)


run : Script
run =
    Script.withCliOptions program run2


introspectSchemaFromUrl : 
    { graphqlUrl : String
    , excludeDeprecated : Bool
    , outputPath : String
    , baseModule : List String
    , headers : Json.Encode.Value
    , customDecodersModule : Maybe String
    } 
    -> BackendTask FatalError Json.Encode.Value
introspectSchemaFromUrl options =
    BackendTask.Custom.run "introspectSchemaFromUrl"
        (Json.Encode.object
            [ ( "graphqlUrl", Json.Encode.string options.graphqlUrl )
            , ( "excludeDeprecated", Json.Encode.bool options.excludeDeprecated )
            , ( "outputPath", Json.Encode.string options.outputPath )
            , ( "baseModule", options.baseModule |> Json.Encode.list Json.Encode.string )
            , ( "headers", options.headers )
            , ( "customDecodersModule", options.customDecodersModule |> Maybe.map Json.Encode.string |> Maybe.withDefault Json.Encode.null )
            ]
        )
        Decode.value
        |> allowFatal


introspectSchemaFromFile :
    { introspectionFilePath : String
    , outputPath : String
    , baseModule : List String
    , customDecodersModule : Maybe String
    }
    -> BackendTask FatalError Json.Encode.Value
introspectSchemaFromFile options =
    BackendTask.Custom.run "introspectSchemaFromFile"
        (Json.Encode.object
            [ ( "introspectionFilePath", Json.Encode.string options.introspectionFilePath )
            , ( "outputPath", Json.Encode.string options.outputPath )
            , ( "baseModule", options.baseModule |> Json.Encode.list Json.Encode.string )
            , ( "customDecodersModule", options.customDecodersModule |> Maybe.map Json.Encode.string |> Maybe.withDefault Json.Encode.null )
            ]
        )
        Decode.value
        |> allowFatal


schemaFromFile :
    { schemaFilePath : String
    , outputPath : String
    , baseModule : List String
    , customDecodersModule : Maybe String
    }
    -> BackendTask FatalError Json.Encode.Value
schemaFromFile options =
    BackendTask.Custom.run "schemaFromFile"
        (Json.Encode.object
            [ ( "schemaFilePath", Json.Encode.string options.schemaFilePath )
            , ( "outputPath", Json.Encode.string options.outputPath )
            , ( "baseModule", options.baseModule |> Json.Encode.list Json.Encode.string )
            , ( "customDecodersModule", options.customDecodersModule |> Maybe.map Json.Encode.string |> Maybe.withDefault Json.Encode.null )
            ]
        )
        Decode.value
        |> allowFatal


generatedFiles : Json.Encode.Value -> BackendTask FatalError ()
generatedFiles json =
    BackendTask.Custom.run "generatedFiles"
        json
        (Decode.succeed ())
        |> allowFatal


run2 : CliOptions -> BackendTask FatalError ()
run2 msg =
    (case msg of
        FromUrl options ->
            introspectSchemaFromUrl
                { graphqlUrl = options.url
                , excludeDeprecated = options.excludeDeprecated
                , outputPath = options.outputPath
                , baseModule = options.base
                , headers = options.headers |> Json.Encode.dict identity Json.Encode.string
                , customDecodersModule =
                    if options.skipValidation then
                        Nothing

                    else
                        options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }

        FromIntrospectionFile options ->
            introspectSchemaFromFile
                { introspectionFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , customDecodersModule =
                    if options.skipValidation then
                        Nothing

                    else
                        options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }

        FromSchemaFile options ->
            schemaFromFile
                { schemaFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , customDecodersModule =
                    if options.skipValidation then
                        Nothing

                    else
                        options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
    )
        |> BackendTask.andThen
            (\introspectionJson ->
                let
                    record : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName, skipElmFormat : Bool, outputPath : String }
                    record =
                        case msg of
                            FromUrl options ->
                                { apiSubmodule = options.base
                                , scalarCodecsModule = options.scalarCodecsModule
                                , skipElmFormat = options.skipElmFormat
                                , outputPath = options.outputPath
                                }

                            FromIntrospectionFile options ->
                                { apiSubmodule = options.base
                                , scalarCodecsModule = options.scalarCodecsModule
                                , skipElmFormat = options.skipElmFormat
                                , outputPath = options.outputPath
                                }

                            FromSchemaFile options ->
                                { apiSubmodule = options.base
                                , scalarCodecsModule = options.scalarCodecsModule
                                , skipElmFormat = options.skipElmFormat
                                , outputPath = options.outputPath
                                }
                in
                run3
                    record
                    introspectionJson
            )


run3 : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName, skipElmFormat : Bool, outputPath : String } -> Json.Encode.Value -> BackendTask FatalError ()
run3 { apiSubmodule, scalarCodecsModule, skipElmFormat, outputPath } introspectionQueryJson =
    let
        decoder : Decoder (Dict String String)
        decoder =
            Graphql.Parser.decoder
                { apiSubmodule = apiSubmodule
                , scalarCodecsModule = scalarCodecsModule
                }
    in
    case Decode.decodeValue decoder introspectionQueryJson of
        Ok fields ->
            {-
               outputPath: string,
               baseModule: string[],
               customDecodersModule: string | null
            -}
            Json.Encode.object
                [ ( "generatedFile", Json.Encode.dict identity Json.Encode.string fields )
                , ( "skipElmFormat", Json.Encode.bool skipElmFormat )
                , ( "baseModule", Json.Encode.list Json.Encode.string apiSubmodule )
                , ( "outputPath", Json.Encode.string outputPath )
                , ( "customDecodersModule", scalarCodecsModule |> Maybe.map ModuleName.toString |> Maybe.withDefault "" |> Json.Encode.string )
                ]
                |> generatedFiles

        Err error ->
            { title = "Invalid introspection schema"
            , body =
                """I couldn't understand the JSON for this schema. Here are some reasons this could fail:

- You may have provided a part of the introspection schema that is incomplete or invalid. Be sure you got it using the correct introspection query, or consider using another option like `elm-graphql --schema-file` if you want to use SDL syntax instead of JSON.
- Perhaps the schema is invalid (even well-established tools sometimes generate incorrect values)
- Or perhaps there's an issue with elm-graphql



            """ ++ Decode.errorToString error
            }
                |> printAndExitFailure


printAndExitFailure :
    { title : String, body : String }
    -> BackendTask FatalError ()
printAndExitFailure error =
    BackendTask.fail (FatalError.build error)


type CliOptions
    = FromUrl UrlArgs
    | FromIntrospectionFile FileArgs
    | FromSchemaFile FileArgs


type alias UrlArgs =
    { url : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    , headers : Dict String String
    , scalarCodecsModule : Maybe ModuleName
    , skipElmFormat : Bool
    , skipValidation : Bool
    }


type alias FileArgs =
    { file : String
    , base : List String
    , outputPath : String
    , scalarCodecsModule : Maybe ModuleName
    , skipElmFormat : Bool
    , skipValidation : Bool
    }


parseHeaders : List String -> Result String (Dict String String)
parseHeaders headers =
    headers
        |> List.map parseHeader
        |> Result.Extra.combine
        |> Result.map Dict.fromList


parseHeader : String -> Result String ( String, String )
parseHeader header =
    case String.split ":" header of
        key :: valueHead :: valueTail ->
            Ok ( key, String.join ":" (valueHead :: valueTail) )

        _ ->
            interpolate "Could not parse header `{0}`. Must be of form `<key>: <value>`, for example `authorization: Bearer abcdefg1234567`."
                [ header ]
                |> Err


program : Program.Config CliOptions
program =
    Program.config
        |> Program.add
            (OptionsParser.build UrlArgs
                |> with (Option.requiredPositionalArg "url")
                |> with baseOption
                |> with outputPathOption
                |> with (Option.flag "exclude-deprecated")
                |> with
                    (Option.keywordArgList "header"
                        |> Option.validateMap parseHeaders
                    )
                |> with scalarCodecsOption
                |> with skipElmFormatOption
                |> with skipScalarCodecValidationOption
                |> OptionsParser.withDoc "generate files based on the schema at `url`"
                |> OptionsParser.map FromUrl
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "introspection-file")
                |> with baseOption
                |> with outputPathOption
                |> with scalarCodecsOption
                |> with skipElmFormatOption
                |> with skipScalarCodecValidationOption
                |> OptionsParser.map FromIntrospectionFile
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "schema-file")
                |> with baseOption
                |> with outputPathOption
                |> with scalarCodecsOption
                |> with skipElmFormatOption
                |> with skipScalarCodecValidationOption
                |> OptionsParser.map FromSchemaFile
            )


scalarCodecsOption : Option.Option (Maybe String) (Maybe ModuleName) Option.BeginningOption
scalarCodecsOption =
    Option.optionalKeywordArg "scalar-codecs"
        |> Option.validateIfPresent validateModuleName
        |> Option.map (Maybe.map (String.split "."))
        |> Option.map (Maybe.map ModuleName.fromList)


skipElmFormatOption : Option.Option Bool Bool Option.BeginningOption
skipElmFormatOption =
    Option.flag "skip-elm-format"


skipScalarCodecValidationOption : Option.Option Bool Bool Option.BeginningOption
skipScalarCodecValidationOption =
    Option.flag "skip-validation"


outputPathOption : Option.Option (Maybe String) String Option.BeginningOption
outputPathOption =
    Option.optionalKeywordArg "output" |> Option.withDefault "./src"


baseOption : Option.Option (Maybe String) (List String) Option.BeginningOption
baseOption =
    Option.optionalKeywordArg "base"
        |> Option.validateIfPresent validateModuleName
        |> Option.map (Maybe.map (String.split "."))
        |> Option.withDefault [ "Api" ]


validateModuleName : String -> Cli.Validate.ValidationResult
validateModuleName =
    Cli.Validate.regexWithMessage "I expected an Elm module name" "^[A-Z][A-Za-z_]*(\\.[A-Z][A-Za-z_]*)*$"
