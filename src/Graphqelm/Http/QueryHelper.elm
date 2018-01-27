module Graphqelm.Http.QueryHelper exposing (HttpMethod(..), build)

import Graphqelm.Document as Document
import Graphqelm.Http.QueryParams as QueryParams
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet)
import Http
import Json.Encode


type HttpMethod
    = Get
    | Post


type alias QueryRequest =
    { method : HttpMethod
    , url : String
    , body : Http.Body
    }


type alias QueryParam =
    ( String, String )


maxLength : number
maxLength =
    2000


build : Maybe HttpMethod -> String -> List QueryParam -> SelectionSet decodesTo RootQuery -> QueryRequest
build forceMethod url queryParams queryDocument =
    let
        urlForGetRequest =
            QueryParams.urlWithQueryParams (queryParams ++ [ ( "query", Document.serializeQueryForUrl queryDocument ) ]) url
    in
    if forceMethod == Just Post || (String.length urlForGetRequest >= maxLength && forceMethod /= Just Get) then
        { method = Post
        , url = QueryParams.urlWithQueryParams [] url
        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string (Document.serializeQuery queryDocument) ) ])
        }
    else
        { method = Get
        , url = urlForGetRequest
        , body = Http.emptyBody
        }
