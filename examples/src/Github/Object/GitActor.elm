module Github.Object.GitActor exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.GitActor
selection constructor =
    Object.selection constructor


{-| A URL pointing to the author's public avatar.

  - size - The size of the resulting square image.

-}
avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Object.GitActor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


{-| The timestamp of the Git action (authoring or committing).
-}
date : FieldDecoder (Maybe String) Github.Object.GitActor
date =
    Object.fieldDecoder "date" [] (Decode.string |> Decode.maybe)


{-| The email in the Git commit.
-}
email : FieldDecoder (Maybe String) Github.Object.GitActor
email =
    Object.fieldDecoder "email" [] (Decode.string |> Decode.maybe)


{-| The name in the Git commit.
-}
name : FieldDecoder (Maybe String) Github.Object.GitActor
name =
    Object.fieldDecoder "name" [] (Decode.string |> Decode.maybe)


{-| The GitHub user corresponding to the email field. Null if no such user exists.
-}
user : SelectionSet selection Github.Object.User -> FieldDecoder (Maybe selection) Github.Object.GitActor
user object =
    Object.selectionFieldDecoder "user" [] object (identity >> Decode.maybe)
