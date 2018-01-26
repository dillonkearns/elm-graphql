module Graphqelm.Http.QueryHelper exposing (HttpMethod(..), build)

import Graphqelm.Document as Document
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet)
import Http


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


build : Maybe HttpMethod -> String -> List QueryParam -> SelectionSet decodesTo RootQuery -> QueryRequest
build forceMethod url queryParams queryDocument =
    let
        getUrl =
            urlWithQueryParams [ ( "query", Document.serializeQueryGET queryDocument ) ] url
    in
    { method = Get
    , url = getUrl
    , body = Http.emptyBody
    }


urlWithQueryParams : List ( String, String ) -> String -> String
urlWithQueryParams queryParams url =
    if List.isEmpty queryParams then
        url
    else
        url ++ "?" ++ joinUrlEncoded queryParams


joinUrlEncoded : List ( String, String ) -> String
joinUrlEncoded args =
    String.join "&" (List.map queryPair args)


queryPair : ( String, String ) -> String
queryPair ( key, value ) =
    queryEscape key ++ "=" ++ queryEscape value


queryEscape : String -> String
queryEscape =
    Http.encodeUri >> replace "%20" "+"


replace : String -> String -> String -> String
replace old new =
    String.split old >> String.join new
