module DemoData exposing (DemoData(..), toMaybe)


type DemoData a
    = TODO
    | DONE a


toMaybe : DemoData a -> Maybe a
toMaybe demoData =
    case demoData of
        TODO ->
            Nothing

        DONE value ->
            Just value
