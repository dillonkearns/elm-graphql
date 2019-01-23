module CustomScalarDecoders exposing (Id, PosixTime, decoders, encoders)

import Graphql.Internal.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder)
import Swapi.Scalar exposing (defaultDecoders)
import Time


type alias Id =
    String


type alias PosixTime =
    Time.Posix


decoders : Swapi.Scalar.Decoders Id PosixTime
decoders =
    Swapi.Scalar.defineDecoders
        { codecId =
            { encoder = Encode.string
            , decoder = Decode.string
            }
        , codecPosixTime =
            { encoder = Time.posixToMillis >> Encode.int
            , decoder = Decode.int |> Decode.map Time.millisToPosix
            }
        }


encoders : { encoderId : String -> Value, encoderPosixTime : Int -> Value }
encoders =
    { encoderId = Encode.string
    , encoderPosixTime = Encode.int
    }
