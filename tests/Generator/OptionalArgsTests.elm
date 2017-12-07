module Generator.OptionalArgsTests exposing (all)

import Expect
import Graphqelm.Generator.OptionalArgs as OptionalArgs
import Test exposing (Test, describe, test)


all : Test
all =
    describe "optional args generator"
        [ test "no optional args" <|
            \() ->
                []
                    |> OptionalArgs.generate
                    |> Expect.equal Nothing
        ]
