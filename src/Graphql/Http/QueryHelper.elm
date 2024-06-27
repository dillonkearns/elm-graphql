module Graphql.Http.QueryHelper exposing (HttpMethod(..), build)

import Graphql.Document as Document
import Graphql.Http.QueryParams as QueryParams
import Graphql.Operation exposing (RootQuery)
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
    if forceMethod == Just Post then
        buildHelp forceMethod url queryParams maybeOperationName queryDocument

    else
        let
            ( serializedQueryForGetRequest, operationNameParamForGetRequest ) =
                case maybeOperationName of
                    Just operationName ->
                        ( Document.serializeQueryForUrlWithOperationName operationName queryDocument
                        , [ ( "operationName", operationName ) ]
                        )

                    Nothing ->
                        ( Document.serializeQueryForUrl queryDocument, [] )

            urlForGetRequest =
                QueryParams.urlWithQueryParams
                    (queryParams ++ ( "query", serializedQueryForGetRequest ) :: operationNameParamForGetRequest)
                    url
        in
        if forceMethod /= Just Get && String.length urlForGetRequest >= maxLength then
            buildHelp forceMethod url queryParams maybeOperationName queryDocument

        else
            { method = Get
            , url = urlForGetRequest
            , body = Http.emptyBody
            }


buildHelp : Maybe HttpMethod -> String -> List QueryParam -> Maybe String -> SelectionSet decodesTo RootQuery -> QueryRequest
buildHelp forceMethod url queryParams maybeOperationName queryDocument =
    let
        ( serializedQuery, operationNameParamForPostRequest ) =
            case maybeOperationName of
                Just operationName ->
                    ( Document.serializeQueryWithOperationName operationName queryDocument
                    , [ ( "operationName", Json.Encode.string operationName ) ]
                    )

                Nothing ->
                    ( Document.serializeQuery queryDocument, [] )
    in
    { method = Post
    , url = QueryParams.urlWithQueryParams queryParams url
    , body =
        Http.jsonBody <|
            Json.Encode.object <|
                ( "query", Json.Encode.string serializedQuery )
                    :: operationNameParamForPostRequest
    }
