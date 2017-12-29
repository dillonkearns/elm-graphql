module Github.Object.CommitComment exposing (..)

import Github.Enum.CommentAuthorAssociation
import Github.Enum.CommentCannotUpdateReason
import Github.Enum.ReactionContent
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.CommitComment
selection constructor =
    Object.object constructor


{-| The actor who authored the comment.
-}
author : SelectionSet author Github.Object.Actor -> FieldDecoder (Maybe author) Github.Object.CommitComment
author object =
    Object.selectionFieldDecoder "author" [] object (identity >> Decode.maybe)


{-| Author's association with the subject of the comment.
-}
authorAssociation : FieldDecoder Github.Enum.CommentAuthorAssociation.CommentAuthorAssociation Github.Object.CommitComment
authorAssociation =
    Object.fieldDecoder "authorAssociation" [] Github.Enum.CommentAuthorAssociation.decoder


{-| Identifies the comment body.
-}
body : FieldDecoder String Github.Object.CommitComment
body =
    Object.fieldDecoder "body" [] Decode.string


{-| Identifies the comment body rendered to HTML.
-}
bodyHTML : FieldDecoder String Github.Object.CommitComment
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


{-| Identifies the commit associated with the comment, if the commit exists.
-}
commit : SelectionSet commit Github.Object.Commit -> FieldDecoder (Maybe commit) Github.Object.CommitComment
commit object =
    Object.selectionFieldDecoder "commit" [] object (identity >> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.CommitComment
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Check if this comment was created via an email reply.
-}
createdViaEmail : FieldDecoder Bool Github.Object.CommitComment
createdViaEmail =
    Object.fieldDecoder "createdViaEmail" [] Decode.bool


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.CommitComment
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


{-| The actor who edited the comment.
-}
editor : SelectionSet editor Github.Object.Actor -> FieldDecoder (Maybe editor) Github.Object.CommitComment
editor object =
    Object.selectionFieldDecoder "editor" [] object (identity >> Decode.maybe)


id : FieldDecoder String Github.Object.CommitComment
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The moment the editor made the last edit
-}
lastEditedAt : FieldDecoder (Maybe String) Github.Object.CommitComment
lastEditedAt =
    Object.fieldDecoder "lastEditedAt" [] (Decode.string |> Decode.maybe)


{-| Identifies the file path associated with the comment.
-}
path : FieldDecoder (Maybe String) Github.Object.CommitComment
path =
    Object.fieldDecoder "path" [] (Decode.string |> Decode.maybe)


{-| Identifies the line position associated with the comment.
-}
position : FieldDecoder (Maybe Int) Github.Object.CommitComment
position =
    Object.fieldDecoder "position" [] (Decode.int |> Decode.maybe)


{-| Identifies when the comment was published at.
-}
publishedAt : FieldDecoder (Maybe String) Github.Object.CommitComment
publishedAt =
    Object.fieldDecoder "publishedAt" [] (Decode.string |> Decode.maybe)


{-| A list of reactions grouped by content left on the subject.
-}
reactionGroups : SelectionSet reactionGroups Github.Object.ReactionGroup -> FieldDecoder (Maybe (List reactionGroups)) Github.Object.CommitComment
reactionGroups object =
    Object.selectionFieldDecoder "reactionGroups" [] object (identity >> Decode.list >> Decode.maybe)


{-| A list of Reactions left on the Issue.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - content - Allows filtering Reactions by emoji.
  - orderBy - Allows specifying the order in which reactions are returned.

-}
reactions : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, content : OptionalArgument Github.Enum.ReactionContent.ReactionContent, orderBy : OptionalArgument Value }) -> SelectionSet reactions Github.Object.ReactionConnection -> FieldDecoder reactions Github.Object.CommitComment
reactions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, content = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "content" filledInOptionals.content (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "reactions" optionalArgs object identity


{-| The repository associated with this node.
-}
repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.CommitComment
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


{-| The HTTP path permalink for this commit comment.
-}
resourcePath : FieldDecoder String Github.Object.CommitComment
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.CommitComment
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL permalink for this commit comment.
-}
url : FieldDecoder String Github.Object.CommitComment
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Check if the current viewer can delete this object.
-}
viewerCanDelete : FieldDecoder Bool Github.Object.CommitComment
viewerCanDelete =
    Object.fieldDecoder "viewerCanDelete" [] Decode.bool


{-| Can user react to this subject
-}
viewerCanReact : FieldDecoder Bool Github.Object.CommitComment
viewerCanReact =
    Object.fieldDecoder "viewerCanReact" [] Decode.bool


{-| Check if the current viewer can update this object.
-}
viewerCanUpdate : FieldDecoder Bool Github.Object.CommitComment
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool


{-| Reasons why the current viewer can not update this comment.
-}
viewerCannotUpdateReasons : FieldDecoder (List Github.Enum.CommentCannotUpdateReason.CommentCannotUpdateReason) Github.Object.CommitComment
viewerCannotUpdateReasons =
    Object.fieldDecoder "viewerCannotUpdateReasons" [] (Github.Enum.CommentCannotUpdateReason.decoder |> Decode.list)


{-| Did the viewer author this comment.
-}
viewerDidAuthor : FieldDecoder Bool Github.Object.CommitComment
viewerDidAuthor =
    Object.fieldDecoder "viewerDidAuthor" [] Decode.bool
