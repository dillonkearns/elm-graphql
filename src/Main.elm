port module Main exposing (..)

import Dict
import GraphqElm.Generator.Group
import GraphqElm.Generator.Module
import GraphqElm.Generator.Object
import GraphqElm.Parser
import GraphqElm.Parser.Type as Type exposing (Field, TypeDefinition)
import Http
import Json.Decode exposing (..)
import Json.Encode
import Json.Encode.Extra


-- Need to import Json.Decode as a
-- workaround for https://github.com/elm-lang/elm-make/issues/134


workaround : Decoder String
workaround =
    Json.Decode.string


type alias Model =
    ()


type alias Flags =
    { data : Json.Decode.Value }


type Msg
    = GotSchema (Result.Result Http.Error String)


queryFile : GraphqElm.Generator.Group.Group -> Dict.Dict String String
queryFile group =
    Dict.fromList
        (( "Api/Query.elm", GraphqElm.Generator.Module.generateNew [ "Query" ] group.queries )
            :: List.map
                (\((Type.TypeDefinition name definableType) as definition) ->
                    case definableType of
                        Type.ObjectType fields ->
                            let
                                { moduleName, moduleContents } =
                                    GraphqElm.Generator.Object.generate definition
                                        |> Debug.log "@@@@"
                            in
                            ( (moduleName |> String.join "/") ++ ".elm", moduleContents )

                        Type.ScalarType _ ->
                            Debug.crash "TODO"
                )
                group.objects
        )


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        fieldsResult =
            Json.Decode.decodeValue GraphqElm.Parser.decoderNew flags.data
    in
    case fieldsResult of
        Ok fields ->
            ( (), generatedFiles (queryFile fields |> Json.Encode.Extra.dict identity Json.Encode.string) )

        Err error ->
            Debug.crash ("Got error " ++ toString error)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSchema response ->
            let
                _ =
                    Debug.log "response" response
            in
            ( model, Cmd.none )


main : Program Flags Model Msg
main =
    Platform.programWithFlags
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }


port generatedFiles : Json.Encode.Value -> Cmd msg


port parsingError : String -> Cmd msg
