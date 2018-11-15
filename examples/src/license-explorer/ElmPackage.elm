module ElmPackage exposing (request)

import Http
import Json.Decode as Decode


request =
    Http.get "https://package.elm-lang.org/search.json" decoder


decoder =
    Decode.list (Decode.field "name" Decode.string)
