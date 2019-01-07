module CustomScalarDecoders exposing (Id, PosixTime, decoders)

import Json.Decode as Decode exposing (Decoder)
import Swapi.Scalar exposing (defaultDecoders)
import Time


type alias Id =
    Swapi.Scalar.Id


type alias PosixTime =
    Time.Posix


decoders : Swapi.Scalar.Decoders Id PosixTime
decoders =
    Swapi.Scalar.defineDecoders
        { decoderId = defaultDecoders.decoderId
        , decoderPosixTime = Decode.int |> Decode.map Time.millisToPosix
        }
