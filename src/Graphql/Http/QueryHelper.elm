module Graphql.Http.QueryHelper exposing (HttpMethod(..), build)

import Graphql.Document as Document
import Graphql.Http.QueryParams as QueryParams
import Graphql.Operation exposing (RootMutation, RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
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


build : Maybe HttpMethod -> String -> List QueryParam -> Maybe String -> SelectionSet decodesTo RootQuery -> QueryRequest
build forceMethod url queryParams maybeOperationName queryDocument =
    let
        serializedQueryForGetRequest =
            case maybeOperationName of
                Just operationName ->
                    Document.serializeQueryForUrlWithOperationName operationName queryDocument

                Nothing ->
                    Document.serializeQueryForUrl queryDocument

        urlForGetRequest =
            QueryParams.urlWithQueryParams (queryParams ++ [ ( "query", serializedQueryForGetRequest ) ]) url
    in
    if forceMethod == Just Post || (String.length urlForGetRequest >= maxLength && forceMethod /= Just Get) then
        let
            serializedQuery =
                case maybeOperationName of
                    Just operationName ->
                        Document.serializeQueryWithOperationName operationName queryDocument

                    Nothing ->
                        Document.serializeQuery queryDocument
        in
        { method = Post
        , url = QueryParams.urlWithQueryParams [] url
        , body = Http.jsonBody (Json.Encode.object [ ( "query", Json.Encode.string serializedQuery ) ])
        }

    else
        { method = Get
        , url = urlForGetRequest
        , body = Http.emptyBody
        }
