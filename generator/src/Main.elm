port module Main exposing (main)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (OptionsParser, with)
import Cli.Program as Program
import Cli.Validate
import Dict
import Graphql.Parser
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode
import Json.Encode.Extra
import ModuleName exposing (ModuleName(..))
import MyDebug
import Ports
import Result.Extra
import String.Interpolate exposing (interpolate)


type Msg
    = GenerateFiles Json.Encode.Value


type alias Model =
    ()


run : { apiSubmodule : List String, scalarDecodersModule : Maybe ModuleName } -> Json.Encode.Value -> Cmd msg
run options introspectionQueryJson =
    case Decode.decodeValue (Graphql.Parser.decoder options) introspectionQueryJson of
        Ok fields ->
            fields
                |> Json.Encode.Extra.dict identity Json.Encode.string
                |> Ports.generatedFiles

        Err error ->
            ("Got error " ++ Decode.errorToString error)
                |> Ports.printAndExitFailure


type CliOptions
    = FromUrl UrlArgs
    | FromFile FileArgs


type alias UrlArgs =
    { url : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    , headers : Dict.Dict String String
    , scalarDecodersModule : Maybe ModuleName
    }


type alias FileArgs =
    { file : String
    , base : List String
    , outputPath : String
    , scalarDecodersModule : Maybe ModuleName
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
        [ key, value ] ->
            Ok ( key, value )

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
                |> with scalarDecodersOption
                |> OptionsParser.withDoc "generate files based on the schema at `url`"
                |> OptionsParser.map FromUrl
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "introspection-file")
                |> with baseOption
                |> with outputPathOption
                |> with scalarDecodersOption
                |> OptionsParser.map FromFile
            )


scalarDecodersOption : Option.Option (Maybe String) (Maybe ModuleName) Option.BeginningOption
scalarDecodersOption =
    Option.optionalKeywordArg "scalar-decoders"
        |> Option.validateIfPresent validateModuleName
        |> Option.map (Maybe.map (String.split "."))
        |> Option.map (Maybe.map ModuleName.fromList)


outputPathOption : Option.Option (Maybe String) String Option.BeginningOption
outputPathOption =
    Option.optionalKeywordArg "output" |> Option.withDefault "./src"


baseOption : Option.Option (Maybe String) (List String) Option.BeginningOption
baseOption =
    Option.optionalKeywordArg "base"
        |> Option.validateIfPresent validateModuleName
        |> Option.map (Maybe.map (String.split "."))
        |> Option.withDefault [ "Api" ]


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
                , customDecodersModule = options.scalarDecodersModule |> Maybe.map ModuleName.toString
                }
            )

        FromFile options ->
            ( ()
            , Ports.introspectSchemaFromFile
                { introspectionFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , customDecodersModule = options.scalarDecodersModule |> Maybe.map ModuleName.toString
                }
            )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    case msg of
        GenerateFiles introspectionJson ->
            let
                ( baseModule, scalarDecodersModule ) =
                    case cliOptions of
                        FromUrl options ->
                            ( options.base, options.scalarDecodersModule )

                        FromFile options ->
                            ( options.base, options.scalarDecodersModule )
            in
            ( (), run { apiSubmodule = baseModule, scalarDecodersModule = scalarDecodersModule } introspectionJson )


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
