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
import Ports


type Msg
    = GenerateFiles Json.Encode.Value


type alias Model =
    ()


run : List String -> Json.Encode.Value -> Cmd msg
run baseModule introspectionQueryJson =
    case Decode.decodeValue (Graphql.Parser.decoder baseModule) introspectionQueryJson of
        Ok fields ->
            fields
                |> Json.Encode.Extra.dict identity Json.Encode.string
                |> Ports.generatedFiles

        Err error ->
            Debug.todo ("Got error " ++ Debug.toString error)


type CliOptions
    = FromUrl UrlArgs
    | FromFile FileArgs


type alias UrlArgs =
    { url : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    , headers : Dict.Dict String String
    }


type alias FileArgs =
    { file : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    }


parseHeaders headers =
    headers
        |> List.filterMap
            (\header ->
                case String.split ":" header of
                    [ key, value ] ->
                        Just ( key, value )

                    _ ->
                        Nothing
            )
        |> Dict.fromList


program : Program.Config CliOptions
program =
    Program.config { version = "1.2.3" }
        |> Program.add
            (OptionsParser.build UrlArgs
                |> with (Option.requiredPositionalArg "url")
                |> with baseOption
                |> with outputPathOption
                |> with (Option.flag "excludeDeprecated")
                |> with
                    (Option.keywordArgList "header"
                        |> Option.map parseHeaders
                    )
                |> OptionsParser.withDoc "generate files based on the schema at `url`"
                |> OptionsParser.map FromUrl
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "introspection-file")
                |> with baseOption
                |> with outputPathOption
                |> with (Option.flag "excludeDeprecated")
                |> OptionsParser.map FromFile
            )


outputPathOption : Option.Option (Maybe String) String Option.BeginningOption
outputPathOption =
    Option.optionalKeywordArg "output" |> Option.withDefault "./src"


baseOption : Option.Option (Maybe String) (List String) Option.BeginningOption
baseOption =
    Option.optionalKeywordArg "base"
        |> Option.validateIfPresent
            (Cli.Validate.regex "^[A-Z][A-Za-z_]*(\\.[A-Z][A-Za-z_]*)*$")
        |> Option.map (Maybe.map (String.split "."))
        |> Option.withDefault [ "Api" ]


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
                }
            )

        FromFile options ->
            ( ()
            , Ports.introspectSchemaFromFile
                { introspectionFilePath = options.file
                , excludeDeprecated = options.excludeDeprecated
                , outputPath = options.outputPath
                , baseModule = options.base
                }
            )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    case msg of
        GenerateFiles introspectionJson ->
            let
                baseModule =
                    case cliOptions of
                        FromUrl { base } ->
                            base

                        FromFile { base } ->
                            base
            in
            ( (), run baseModule introspectionJson )


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
