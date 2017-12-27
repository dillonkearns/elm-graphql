module Graphqelm.Http exposing (Error, Request, buildMutationRequest, buildQueryRequest, send, withHeader, withTimeout)

{-| Send requests to your GraphQL endpoint. See the `examples/` folder for an end-to-end example.
The builder syntax is inspired by Luke Westby's
[elm-http-builder package](http://package.elm-lang.org/packages/lukewestby/elm-http-builder/latest).

@docs buildQueryRequest, buildMutationRequest, send, withHeader, withTimeout
@docs Request, Error

-}

import Graphqelm exposing (RootMutation, RootQuery)
import Graphqelm.Document as Document
import Graphqelm.Document.LowLevel as Document
import Graphqelm.Http.GraphqlError as GraphqlError
import Graphqelm.SelectionSet exposing (SelectionSet)
import Http
import Json.Decode
import Json.Encode
import Time exposing (Time)


{-| TODO
-}
type Request decodesTo
    = Request
        { method : String
        , headers : List Http.Header
        , url : String
        , body : Http.Body
        , expect : Json.Decode.Decoder decodesTo
        , timeout : Maybe Time
        , withCredentials : Bool
        }


{-| TODO
-}
buildRequest : String -> String -> SelectionSet decodesTo typeLock -> Request decodesTo
buildRequest url queryDocument query =
    { method = "POST"
    , headers = []
    , url = url
    , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string queryDocument ) ])
    , expect = Document.decoder query
    , timeout = Nothing
    , withCredentials = False
    }
        |> Request


{-| TODO
-}
buildQueryRequest : String -> SelectionSet decodesTo RootQuery -> Request decodesTo
buildQueryRequest url query =
    buildRequest url (Document.serializeQuery query) query


{-| TODO
-}
buildMutationRequest : String -> SelectionSet decodesTo RootMutation -> Request decodesTo
buildMutationRequest url query =
    buildRequest url (Document.serializeMutation query) query


{-| TODO
-}
type Error
    = GraphqlError (List GraphqlError.GraphqlError)
    | HttpError Http.Error


type SuccessOrError a
    = Success a
    | ErrorThing (List GraphqlError.GraphqlError)


convertResult : Result Http.Error (SuccessOrError a) -> Result Error a
convertResult httpResult =
    case httpResult of
        Ok successOrError ->
            case successOrError of
                Success value ->
                    Ok value

                ErrorThing error ->
                    Err (GraphqlError error)

        Err httpError ->
            Err (HttpError httpError)


{-| Send the `Graphqelm.Request`
You can use it on its own, or with a library like
[RemoteData](http://package.elm-lang.org/packages/krisajenkins/remotedata/latest/).


## With RemoteData

    import Graphqelm.Http
    import Graphqelm.OptionalArgument exposing (OptionalArgument(Null, Present))
    import RemoteData exposing (RemoteData)

    type Msg
        = GotResponse RemoteData Graphqelm.Http.Error Response

    makeRequest : Cmd Msg
    makeRequest =
        query
            |> Graphqelm.Http.buildQueryRequest "https://graphqelm.herokuapp.com/"
            |> Graphqelm.Http.withHeader "authorization" "Bearer abcdefgh12345678"
            -- If you're not using remote data, it's just
            -- |> Graphqelm.Http.send GotResponse
            -- Otherwise, it's as below
            |> Graphqelm.Http.send (RemoteData.fromResult >> GotResponse)

-}
send : (Result Error a -> msg) -> Request a -> Cmd msg
send resultToMessage graphqelmRequest =
    graphqelmRequest
        |> toRequest
        |> Http.send (convertResult >> resultToMessage)


toRequest : Request decodesTo -> Http.Request (SuccessOrError decodesTo)
toRequest (Request request) =
    { request | expect = Http.expectJson (decoderOrError request.expect) }
        |> Http.request


decoderOrError : Json.Decode.Decoder a -> Json.Decode.Decoder (SuccessOrError a)
decoderOrError decoder =
    Json.Decode.oneOf
        [ decoder |> Json.Decode.map Success
        , GraphqlError.decoder |> Json.Decode.map ErrorThing
        ]


{-| Add a header.
-}
withHeader : String -> String -> Request decodesTo -> Request decodesTo
withHeader key value (Request request) =
    Request { request | headers = Http.header key value :: request.headers }


{-| Add a timeout.
-}
withTimeout : Time -> Request decodesTo -> Request decodesTo
withTimeout timeout (Request request) =
    Request { request | timeout = Just timeout }


{-| Set with credentials to true.
-}
withCredentials : Request decodesTo -> Request decodesTo
withCredentials (Request request) =
    Request { request | withCredentials = True }
