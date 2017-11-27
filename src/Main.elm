port module Main exposing (..)

import GraphqElm.Generator.Module
import GraphqElm.Parser
import Json.Decode exposing (..)


-- Need to import Json.Decode as a
-- workaround for https://github.com/elm-lang/elm-make/issues/134


workaround : Decoder String
workaround =
    Json.Decode.string


type alias Model =
    ()


type alias Flags =
    { graphqlUrl : String }


fields : List GraphqElm.Parser.Field
fields =
    Json.Decode.decodeString GraphqElm.Parser.decoder schemaJsonString
        |> Result.withDefault []



-- queryFile : String


queryFile : String
queryFile =
    GraphqElm.Generator.Module.generate fields


init : Flags -> ( Model, Cmd msg )
init flags =
    () ! [ generatedFiles queryFile ]


update : msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


main : Program Flags Model msg
main =
    Platform.programWithFlags
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }


port generatedFiles : String -> Cmd msg


port parsingError : String -> Cmd msg


schemaJsonString : String
schemaJsonString =
    """
    {
  "data": {
    "__schema": {
      "types": [
        {
          "possibleTypes": null,
          "name": "RootQueryType",
          "kind": "OBJECT",
          "interfaces": [],
          "inputFields": null,
          "fields": [
            {
              "type": {
                "ofType": {
                  "ofType": {
                    "ofType": null,
                    "name": "String",
                    "kind": "SCALAR"
                  },
                  "name": null,
                  "kind": "NON_NULL"
                },
                "name": null,
                "kind": "LIST"
              },
              "name": "captains",
              "isDeprecated": false,
              "description": null,
              "deprecationReason": null,
              "args": []
            },
            {
              "type": {
                "ofType": {
                  "ofType": null,
                  "name": "String",
                  "kind": "SCALAR"
                },
                "name": null,
                "kind": "NON_NULL"
              },
              "name": "me",
              "isDeprecated": false,
              "description": null,
              "deprecationReason": null,
              "args": []
            }
          ],
          "enumValues": null,
          "description": null
        }
      ]
    }
  }
}

    """
