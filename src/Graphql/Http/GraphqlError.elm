module Graphql.Http.GraphqlError exposing (GraphqlError, decoder, Location, PossiblyParsedData(..))

{-|

@docs GraphqlError, decoder, Location, PossiblyParsedData

-}

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)


{-| Represents an error from the GraphQL endpoint. Also see `Graphql.Http`.

The code generated by `dillonkearns/elm-graphql`
guarantees that your requests are valid according to the server's schema, so
the two cases where you will get a GraphqlError are 1) when there is an implicit
constraint that the schema doesn't specify, or 2) when your generated code is
out of date with the schema.

See the
[Errors section in the GraphQL spec](https://spec.graphql.org/October2016/#sec-Errors)
for more details about GraphQL errors.

-}
type alias GraphqlError =
    { message : String
    , locations : Maybe (List Location)
    , details : Dict String Decode.Value
    }


{-| Represents the `data` field in cases where there is an error present, see
[the error section in the GraphQL spec](https://spec.graphql.org/October2016/#sec-Data)
If the decoder succeeds you will end up with `ParsedData`. If it fails, you
will get an `UnparsedData` with a `Json.Decode.Value` containing the raw, undecoded
`data` field. You're likely to end up with `UnparsedData` since
[GraphQL will return `null` if there is an error on a non-nullable field](https://spec.graphql.org/October2016/#sec-Errors-and-Non-Nullability)
, which will cause the decode pipeline to fail and give you `UnparsedData`.
-}
type PossiblyParsedData parsed
    = ParsedData parsed
    | UnparsedData Decode.Value


{-| For internal use only.
-}
decoder : Decoder (List GraphqlError)
decoder =
    Decode.map3 GraphqlError
        (Decode.field "message" Decode.string)
        (Decode.maybe (Decode.field "locations" (Decode.list locationDecoder)))
        (Decode.dict Decode.value
            |> Decode.map (Dict.remove "message")
            |> Decode.map (Dict.remove "locations")
        )
        |> Decode.list
        |> Decode.field "errors"


{-| The location in the GraphQL query document where the error occured
-}
type alias Location =
    { line : Int, column : Int }


locationDecoder : Decoder Location
locationDecoder =
    Decode.map2 Location
        (Decode.field "line" Decode.int)
        (Decode.field "column" Decode.int)
