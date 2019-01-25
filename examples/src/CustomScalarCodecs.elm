module CustomScalarCodecs exposing (Id, PosixTime, codecs)

import Graphql.Internal.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Swapi.Scalar exposing (defaultCodecs)
import Time


type alias Id =
    Int


type alias PosixTime =
    Time.Posix


codecs : Swapi.Scalar.Codecs Id PosixTime
codecs =
    Swapi.Scalar.defineCodecs
        { codecId =
            { encoder = Encode.int
            , decoder = Decode.int
            }
        , codecPosixTime =
            { encoder = Time.posixToMillis >> Encode.int
            , decoder = Decode.int |> Decode.map Time.millisToPosix
            }
        }
