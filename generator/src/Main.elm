port module Main exposing (main)

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (OptionsParser, with)
import Cli.Program as Program
import Cli.Validate
import Debug
import Dict
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Group as Group
import Graphql.Generator.Normalize as Normalize
import Graphql.Parser
import Graphql.Parser.ClassCaseName as ClassCaseName exposing (ClassCaseName)
import Graphql.QuerySelectionGenerator
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Encode
import Json.Encode.Extra
import ModuleFragmentsGenerator
import ModuleName exposing (ModuleName(..))
import MyDebug
import Ports
import Result.Extra
import String.Interpolate exposing (interpolate)


type Msg
    = GenerateFiles { queryFiles : Json.Encode.Value, introspectionData : Json.Encode.Value }


type alias Model =
    ()


run : { apiSubmodule : List String, scalarCodecsModule : Maybe ModuleName } -> { queryFiles : Json.Encode.Value, introspectionData : Json.Encode.Value } -> Cmd msg
run options data =
    let
        introspectionDataResult =
            data.introspectionData
                |> Decode.decodeValue Graphql.Parser.decoder

        queryFilesResult =
            data.queryFiles
                |> Decode.decodeValue (Decode.dict Decode.string)
    in
    Result.map2 Tuple.pair introspectionDataResult queryFilesResult
        |> Result.mapError (\error -> "Got error decoding" ++ Decode.errorToString error)
        |> Result.andThen
            (\( introspectData, queryFiles ) ->
                let
                    context : Context
                    context =
                        { query = ClassCaseName.build introspectData.queryObjectName
                        , mutation = introspectData.mutationObjectName |> Maybe.map ClassCaseName.build
                        , subscription = introspectData.subscriptionObjectName |> Maybe.map ClassCaseName.build
                        , apiSubmodule = options.apiSubmodule
                        , interfaces = Group.interfacePossibleTypesDict introspectData.typeDefinitions
                        , scalarCodecsModule = options.scalarCodecsModule
                        }

                    generatedLibFiles =
                        introspectData
                            |> Graphql.Parser.encoder options

                    generatedQueryFilesResult =
                        queryFiles
                            |> Dict.toList
                            |> List.map
                                (\( queryFileName, query ) ->
                                    let
                                        maybeModulePath =
                                            queryFileName
                                                |> String.split "."
                                                |> List.head
                                                |> Maybe.map Normalize.capitalized
                                                |> Maybe.map (\moduleName -> [ "Queries", moduleName ])
                                                |> Maybe.map ((++) options.apiSubmodule)
                                    in
                                    case maybeModulePath of
                                        Nothing ->
                                            Err ("Unable to name file" ++ queryFileName)

                                        Just modulePath ->
                                            query
                                                |> Graphql.QuerySelectionGenerator.transform options introspectData context modulePath
                                                |> Debug.log "transformResult!!"
                                                |> Result.map
                                                    (\contents -> ( Group.moduleToFileName modulePath, contents ))
                                )
                            |> Result.Extra.combine
                in
                generatedQueryFilesResult
                    |> Result.map Dict.fromList
                    |> Result.map
                        (\generatedQueryFiles ->
                            generatedLibFiles
                                |> Dict.union generatedQueryFiles
                                |> Json.Encode.Extra.dict identity Json.Encode.string
                        )
            )
        |> Result.map Ports.generatedFiles
        |> Result.mapError Ports.printAndExitFailure
        |> Result.Extra.merge


type CliOptions
    = FromUrl UrlArgs
    | FromFile FileArgs


type alias UrlArgs =
    { url : String
    , base : List String
    , outputPath : String
    , excludeDeprecated : Bool
    , headers : Dict.Dict String String
    , scalarCodecsModule : Maybe ModuleName
    , queryDirectory : Maybe String
    }


type alias FileArgs =
    { file : String
    , base : List String
    , outputPath : String
    , scalarCodecsModule : Maybe ModuleName
    , queryDirectory : Maybe String
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
                |> with scalarCodecsOption
                |> with queriesDirectoryOption
                |> OptionsParser.withDoc "generate files based on the schema at `url`"
                |> OptionsParser.map FromUrl
            )
        |> Program.add
            (OptionsParser.build FileArgs
                |> with (Option.requiredKeywordArg "introspection-file")
                |> with baseOption
                |> with outputPathOption
                |> with scalarCodecsOption
                |> with queriesDirectoryOption
                |> OptionsParser.map FromFile
            )


scalarCodecsOption : Option.Option (Maybe String) (Maybe ModuleName) Option.BeginningOption
scalarCodecsOption =
    Option.optionalKeywordArg "scalar-codecs"
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


queriesDirectoryOption : Option.Option (Maybe String) (Maybe String) Option.BeginningOption
queriesDirectoryOption =
    Option.optionalKeywordArg "queryDirectory"


validateModuleName : String -> Cli.Validate.ValidationResult
validateModuleName =
    Cli.Validate.regex "^[A-Z][A-Za-z_]*(\\.[A-Z][A-Za-z_]*)*$"


type alias Flags =
    Program.FlagsIncludingArgv { elmi : String, elmiFiles : Decode.Value }


init : Flags -> CliOptions -> ( Model, Cmd msg )
init flags msg =
    let
        _ =
            Debug.log "@@@@@@" (ModuleFragmentsGenerator.init flags.elmiFiles)
    in
    case msg of
        FromUrl options ->
            ( ()
            , Ports.introspectSchemaFromUrl
                { graphqlUrl = options.url
                , excludeDeprecated = options.excludeDeprecated
                , outputPath = options.outputPath
                , queryDirectory = options.queryDirectory
                , baseModule = options.base
                , headers = options.headers |> Json.Encode.dict identity Json.Encode.string
                , customDecodersModule = options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
            )

        FromFile options ->
            ( ()
            , Ports.introspectSchemaFromFile
                { introspectionFilePath = options.file
                , outputPath = options.outputPath
                , baseModule = options.base
                , queryDirectory = options.queryDirectory
                , customDecodersModule = options.scalarCodecsModule |> Maybe.map ModuleName.toString
                }
            )


update : CliOptions -> Msg -> Model -> ( Model, Cmd Msg )
update cliOptions msg model =
    case msg of
        GenerateFiles result ->
            let
                ( baseModule, scalarCodecsModule ) =
                    case cliOptions of
                        FromUrl options ->
                            ( options.base, options.scalarCodecsModule )

                        FromFile options ->
                            ( options.base, options.scalarCodecsModule )
            in
            ( (), run { apiSubmodule = baseModule, scalarCodecsModule = scalarCodecsModule } result )


main : Program.StatefulProgram Model Msg CliOptions { elmi : String, elmiFiles : Decode.Value }
main =
    Program.stateful
        { printAndExitFailure = Ports.printAndExitFailure
        , printAndExitSuccess = Ports.printAndExitSuccess
        , init = init
        , subscriptions = \_ -> Ports.generateFiles GenerateFiles
        , update = update
        , config = program
        }
