module CustomScalarCodecs exposing (Id(..), PosixTime, codecs)

import Json.Decode as Decode
import Json.Encode as Encode
import Swapi.Scalar
import Time


type Id
    = Id Int


type alias PosixTime =
    Time.Posix


codecs : Swapi.Scalar.Codecs Id PosixTime
codecs =
    Swapi.Scalar.defineCodecs
        { codecId =
            { encoder = \(Id raw) -> raw |> String.fromInt |> Encode.string
            , decoder =
                Decode.string
                    |> Decode.map String.toInt
                    |> Decode.andThen
                        (\maybeParsedId ->
                            case maybeParsedId of
                                Just parsedId ->
                                    Decode.succeed parsedId

                                Nothing ->
                                    Decode.fail "Could not parse ID as an Int."
                        )
                    |> Decode.map Id
            }
        , codecPosixTime =
            { encoder = Time.posixToMillis >> Encode.int
            , decoder = Decode.int |> Decode.map Time.millisToPosix
            }
        }
