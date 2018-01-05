module Github.Object.CommitCommentThread exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitCommentThread
selection constructor =
    Object.object constructor


{-| The comments that exist in this thread.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.CommitCommentConnection -> FieldDecoder selection Github.Object.CommitCommentThread
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


{-| The commit the comments were made on.
-}
commit : SelectionSet selection Github.Object.Commit -> FieldDecoder selection Github.Object.CommitCommentThread
commit object =
    Object.selectionFieldDecoder "commit" [] object identity


id : FieldDecoder String Github.Object.CommitCommentThread
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The file the comments were made on.
-}
path : FieldDecoder (Maybe String) Github.Object.CommitCommentThread
path =
    Object.fieldDecoder "path" [] (Decode.string |> Decode.maybe)


{-| The position in the diff for the commit that the comment was made on.
-}
position : FieldDecoder (Maybe Int) Github.Object.CommitCommentThread
position =
    Object.fieldDecoder "position" [] (Decode.int |> Decode.maybe)


{-| The repository associated with this node.
-}
repository : SelectionSet selection Github.Object.Repository -> FieldDecoder selection Github.Object.CommitCommentThread
repository object =
    Object.selectionFieldDecoder "repository" [] object identity
