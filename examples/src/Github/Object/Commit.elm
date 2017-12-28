module Github.Object.Commit exposing (..)

import Github.Enum.SubscriptionState
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Commit
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Github.Object.Commit
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


additions : FieldDecoder Int Github.Object.Commit
additions =
    Object.fieldDecoder "additions" [] Decode.int


author : SelectionSet author Github.Object.GitActor -> FieldDecoder author Github.Object.Commit
author object =
    Object.selectionFieldDecoder "author" [] object identity


authoredByCommitter : FieldDecoder Bool Github.Object.Commit
authoredByCommitter =
    Object.fieldDecoder "authoredByCommitter" [] Decode.bool


authoredDate : FieldDecoder String Github.Object.Commit
authoredDate =
    Object.fieldDecoder "authoredDate" [] Decode.string


blame : { path : String } -> SelectionSet blame Github.Object.Blame -> FieldDecoder blame Github.Object.Commit
blame requiredArgs object =
    Object.selectionFieldDecoder "blame" [ Argument.string "path" requiredArgs.path ] object identity


changedFiles : FieldDecoder Int Github.Object.Commit
changedFiles =
    Object.fieldDecoder "changedFiles" [] Decode.int


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.CommitCommentConnection -> FieldDecoder comments Github.Object.Commit
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


commitResourcePath : FieldDecoder String Github.Object.Commit
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Github.Object.Commit
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


committedDate : FieldDecoder String Github.Object.Commit
committedDate =
    Object.fieldDecoder "committedDate" [] Decode.string


committedViaWeb : FieldDecoder Bool Github.Object.Commit
committedViaWeb =
    Object.fieldDecoder "committedViaWeb" [] Decode.bool


committer : SelectionSet committer Github.Object.GitActor -> FieldDecoder committer Github.Object.Commit
committer object =
    Object.selectionFieldDecoder "committer" [] object identity


deletions : FieldDecoder Int Github.Object.Commit
deletions =
    Object.fieldDecoder "deletions" [] Decode.int


history : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String }) -> SelectionSet history Github.Object.CommitHistoryConnection -> FieldDecoder history Github.Object.Commit
history fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, path = Absent, author = Absent, since = Absent, until = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "path" filledInOptionals.path Encode.string, Argument.optional "author" filledInOptionals.author identity, Argument.optional "since" filledInOptionals.since Encode.string, Argument.optional "until" filledInOptionals.until Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "history" optionalArgs object identity


id : FieldDecoder String Github.Object.Commit
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Github.Object.Commit
message =
    Object.fieldDecoder "message" [] Decode.string


messageBody : FieldDecoder String Github.Object.Commit
messageBody =
    Object.fieldDecoder "messageBody" [] Decode.string


messageBodyHTML : FieldDecoder String Github.Object.Commit
messageBodyHTML =
    Object.fieldDecoder "messageBodyHTML" [] Decode.string


messageHeadline : FieldDecoder String Github.Object.Commit
messageHeadline =
    Object.fieldDecoder "messageHeadline" [] Decode.string


messageHeadlineHTML : FieldDecoder String Github.Object.Commit
messageHeadlineHTML =
    Object.fieldDecoder "messageHeadlineHTML" [] Decode.string


oid : FieldDecoder String Github.Object.Commit
oid =
    Object.fieldDecoder "oid" [] Decode.string


parents : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet parents Github.Object.CommitConnection -> FieldDecoder parents Github.Object.Commit
parents fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "parents" optionalArgs object identity


pushedDate : FieldDecoder String Github.Object.Commit
pushedDate =
    Object.fieldDecoder "pushedDate" [] Decode.string


repository : SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Commit
repository object =
    Object.selectionFieldDecoder "repository" [] object identity


resourcePath : FieldDecoder String Github.Object.Commit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


signature : SelectionSet signature Github.Object.GitSignature -> FieldDecoder signature Github.Object.Commit
signature object =
    Object.selectionFieldDecoder "signature" [] object identity


status : SelectionSet status Github.Object.Status -> FieldDecoder status Github.Object.Commit
status object =
    Object.selectionFieldDecoder "status" [] object identity


tarballUrl : FieldDecoder String Github.Object.Commit
tarballUrl =
    Object.fieldDecoder "tarballUrl" [] Decode.string


tree : SelectionSet tree Github.Object.Tree -> FieldDecoder tree Github.Object.Commit
tree object =
    Object.selectionFieldDecoder "tree" [] object identity


treeResourcePath : FieldDecoder String Github.Object.Commit
treeResourcePath =
    Object.fieldDecoder "treeResourcePath" [] Decode.string


treeUrl : FieldDecoder String Github.Object.Commit
treeUrl =
    Object.fieldDecoder "treeUrl" [] Decode.string


url : FieldDecoder String Github.Object.Commit
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanSubscribe : FieldDecoder Bool Github.Object.Commit
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Commit
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder


zipballUrl : FieldDecoder String Github.Object.Commit
zipballUrl =
    Object.fieldDecoder "zipballUrl" [] Decode.string
