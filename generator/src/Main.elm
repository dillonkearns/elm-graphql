module Main exposing (main)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (OptionsParser, with)
import Cli.Program as Program
import Cli.Validate
import Dict
import Graphql.Parser
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode
import ModuleName exposing (ModuleName(..))
import Ports
import Result.Extra
import String.Interpolate exposing (interpolate)


type Msg
    = GenerateFiles Json.Encode.Value


type alias Model =
    ()


run : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName, skipElmFormat : Bool } -> Json.Encode.Value -> Cmd msg
run { apiSubmodule, scalarCodecsModule, skipElmFormat } introspectionQueryJson =
    let
        decoder =
            Graphql.Parser.decoder
                { apiSubmodule = apiSubmodule
                , scalarCodecsModule = scalarCodecsModule
                }
    in
    case Decode.decodeValue decoder introspectionQueryJson of
        Ok fields ->
            Json.Encode.object
                [ ( "generatedFile", Json.Encode.dict identity Json.Encode.string fields )
                , ( "skipElmFormat", Json.Encode.bool skipElmFormat )
                ]
                |> Ports.generatedFiles

        Err error ->
            ("Got error " ++ Decode.errorToString error)
                |> Ports.printAndExitFailure


type CliOptions
    = FromUrl UrlArgs
    | FromIntrospectionFile FileArgs
    | FromSchemaFile FileArgs


type alias UrlArgs =
    { url : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    , headers : Dict.Dict String String
    , scalarCodecsModule : Maybe ModuleName
    , skipElmFormat : Bool
    }


type alias FileArgs =
    { file : String
    , base : List String
    , outputPath : String
    , scalarCodecsModule : Maybe ModuleName
    , skipElmFormat : Bool
    }


parseHeaders : List String -> Result String (Dict.Dict String String)
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
                |> OptionsParser.map FromIntrospectionFile
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "schema-file")
                |> with baseOption
                |> with outputPathOption
                |> with scalarCodecsOption
                |> with skipElmFormatOption
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
    Cli.Validate.regex "^[A-Z][A-Za-z_]*(\\.[A-Z][A-Za-z_]*)*$"


type alias Flags =
    Program.FlagsIncludingArgv {}


init : Flags -> CliOptions -> ( Model, Cmd msg )
init flags msg =
    case msg of
        FromUrl options ->
            ( ()
            , Ports.introspectSchemaFromUrl
                { graphqlUrl = options.url
                , excludeDeprecated = options.excludeDeprecated
                , outputPath = options.outputPath
                , baseModule = options.base
                , headers = options.headers |> Json.Encode.dict identity Json.Encode.string
                , customDecodersModule = options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
            )

        FromIntrospectionFile options ->
            ( ()
            , Ports.introspectSchemaFromFile
                { introspectionFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , customDecodersModule = options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
            )

        FromSchemaFile options ->
            ( ()
            , Ports.schemaFromFile
                { schemaFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , customDecodersModule = options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
            )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    case msg of
        GenerateFiles introspectionJson ->
            let
                ( baseModule, scalarCodecsModule, skipElmFormat ) =
                    case cliOptions of
                        FromUrl options ->
                            ( options.base, options.scalarCodecsModule, options.skipElmFormat )

                        FromIntrospectionFile options ->
                            ( options.base, options.scalarCodecsModule, options.skipElmFormat )

                        FromSchemaFile options ->
                            ( options.base, options.scalarCodecsModule, options.skipElmFormat )
            in
            ( ()
            , run
                { apiSubmodule = baseModule
                , scalarCodecsModule = scalarCodecsModule
                , skipElmFormat = skipElmFormat
                }
                introspectionJson
            )


main : Program.StatefulProgram Model Msg CliOptions {}
main =
    Program.stateful
        { printAndExitFailure = Ports.printAndExitFailure
        , printAndExitSuccess = Ports.printAndExitSuccess
        , init = init
        , subscriptions = \_ -> Ports.generateFiles GenerateFiles
        , update = update
        , config = program
        }
