module CustomScalarDecoders exposing (Id, PosixTime, decoders)

import Graphql.Internal.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Swapi.Scalar exposing (defaultDecoders)
import Time


type alias Id =
    Int


type alias PosixTime =
    Time.Posix


decoders : Swapi.Scalar.Decoders Id PosixTime
decoders =
    Swapi.Scalar.defineDecoders
        { codecId =
            { encoder = Encode.int
            , decoder = Decode.int
            }
        , codecPosixTime =
            { encoder = Time.posixToMillis >> Encode.int
            , decoder = Decode.int |> Decode.map Time.millisToPosix
            }
        }
