module Github.Enum.TeamMemberRole exposing (..)

import Json.Decode as Decode exposing (Decoder)


type TeamMemberRole
    = MAINTAINER
    | MEMBER


decoder : Decoder TeamMemberRole
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "MAINTAINER" ->
                        Decode.succeed MAINTAINER

                    "MEMBER" ->
                        Decode.succeed MEMBER

                    _ ->
                        Decode.fail ("Invalid TeamMemberRole type, " ++ string ++ " try re-running the graphqelm CLI ")
            )
