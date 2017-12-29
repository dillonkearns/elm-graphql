module Github.Object.Actor exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Actor
selection constructor =
    Object.object constructor


{-| A URL pointing to the actor's public avatar.

  - size - The size of the resulting square image.

-}
avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Object.Actor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


{-| The username of the actor.
-}
login : FieldDecoder String Github.Object.Actor
login =
    Object.fieldDecoder "login" [] Decode.string


{-| The HTTP path for this actor.
-}
resourcePath : FieldDecoder String Github.Object.Actor
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The HTTP URL for this actor.
-}
url : FieldDecoder String Github.Object.Actor
url =
    Object.fieldDecoder "url" [] Decode.string
