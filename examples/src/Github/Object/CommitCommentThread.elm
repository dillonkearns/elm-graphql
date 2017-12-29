module Github.Object.CommitCommentThread exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitCommentThread
selection constructor =
    Object.object constructor


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.CommitCommentConnection -> FieldDecoder comments Github.Object.CommitCommentThread
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


commit : SelectionSet commit Github.Object.Commit -> FieldDecoder commit Github.Object.CommitCommentThread
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


id : FieldDecoder String Github.Object.CommitCommentThread
id =
    Object.fieldDecoder "id" [] Decode.string


path : FieldDecoder (Maybe String) Github.Object.CommitCommentThread
path =
    Object.fieldDecoder "path" [] (Decode.string |> Decode.maybe)


position : FieldDecoder (Maybe Int) Github.Object.CommitCommentThread
position =
    Object.fieldDecoder "position" [] (Decode.int |> Decode.maybe)


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.CommitCommentThread
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
