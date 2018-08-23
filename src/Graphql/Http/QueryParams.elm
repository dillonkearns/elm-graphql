module Graphql.Http.QueryParams exposing (urlWithQueryParams)

import Url


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
    Url.percentEncode >> replace "%20" "+"


replace : String -> String -> String -> String
replace old new =
    String.split old >> String.join new
