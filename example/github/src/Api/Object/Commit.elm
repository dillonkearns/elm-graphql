module Api.Object.Commit exposing (..)

import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Commit
selection constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Commit
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


additions : FieldDecoder Int Api.Object.Commit
additions =
    Object.fieldDecoder "additions" [] Decode.int


author : SelectionSet author Api.Object.GitActor -> FieldDecoder author Api.Object.Commit
author object =
    Object.single "author" [] object


authoredByCommitter : FieldDecoder Bool Api.Object.Commit
authoredByCommitter =
    Object.fieldDecoder "authoredByCommitter" [] Decode.bool


authoredDate : FieldDecoder String Api.Object.Commit
authoredDate =
    Object.fieldDecoder "authoredDate" [] Decode.string


blame : { path : String } -> SelectionSet blame Api.Object.Blame -> FieldDecoder blame Api.Object.Commit
blame requiredArgs object =
    Object.single "blame" [ Argument.string "path" requiredArgs.path ] object


changedFiles : FieldDecoder Int Api.Object.Commit
changedFiles =
    Object.fieldDecoder "changedFiles" [] Decode.int


comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Api.Object.CommitCommentConnection -> FieldDecoder comments Api.Object.Commit
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "comments" optionalArgs object


commitResourcePath : FieldDecoder String Api.Object.Commit
commitResourcePath =
    Object.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Commit
commitUrl =
    Object.fieldDecoder "commitUrl" [] Decode.string


committedDate : FieldDecoder String Api.Object.Commit
committedDate =
    Object.fieldDecoder "committedDate" [] Decode.string


committedViaWeb : FieldDecoder Bool Api.Object.Commit
committedViaWeb =
    Object.fieldDecoder "committedViaWeb" [] Decode.bool


committer : SelectionSet committer Api.Object.GitActor -> FieldDecoder committer Api.Object.Commit
committer object =
    Object.single "committer" [] object


deletions : FieldDecoder Int Api.Object.Commit
deletions =
    Object.fieldDecoder "deletions" [] Decode.int


history : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, path : OptionalArgument String, author : OptionalArgument Value, since : OptionalArgument String, until : OptionalArgument String }) -> SelectionSet history Api.Object.CommitHistoryConnection -> FieldDecoder history Api.Object.Commit
history fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, path = Absent, author = Absent, since = Absent, until = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "path" filledInOptionals.path Encode.string, Argument.optional "author" filledInOptionals.author identity, Argument.optional "since" filledInOptionals.since Encode.string, Argument.optional "until" filledInOptionals.until Encode.string ]
                |> List.filterMap identity
    in
    Object.single "history" optionalArgs object


id : FieldDecoder String Api.Object.Commit
id =
    Object.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Api.Object.Commit
message =
    Object.fieldDecoder "message" [] Decode.string


messageBody : FieldDecoder String Api.Object.Commit
messageBody =
    Object.fieldDecoder "messageBody" [] Decode.string


messageBodyHTML : FieldDecoder String Api.Object.Commit
messageBodyHTML =
    Object.fieldDecoder "messageBodyHTML" [] Decode.string


messageHeadline : FieldDecoder String Api.Object.Commit
messageHeadline =
    Object.fieldDecoder "messageHeadline" [] Decode.string


messageHeadlineHTML : FieldDecoder String Api.Object.Commit
messageHeadlineHTML =
    Object.fieldDecoder "messageHeadlineHTML" [] Decode.string


oid : FieldDecoder String Api.Object.Commit
oid =
    Object.fieldDecoder "oid" [] Decode.string


parents : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet parents Api.Object.CommitConnection -> FieldDecoder parents Api.Object.Commit
parents fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "parents" optionalArgs object


pushedDate : FieldDecoder String Api.Object.Commit
pushedDate =
    Object.fieldDecoder "pushedDate" [] Decode.string


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.Commit
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Commit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


signature : SelectionSet signature Api.Object.GitSignature -> FieldDecoder signature Api.Object.Commit
signature object =
    Object.single "signature" [] object


status : SelectionSet status Api.Object.Status -> FieldDecoder status Api.Object.Commit
status object =
    Object.single "status" [] object


tarballUrl : FieldDecoder String Api.Object.Commit
tarballUrl =
    Object.fieldDecoder "tarballUrl" [] Decode.string


tree : SelectionSet tree Api.Object.Tree -> FieldDecoder tree Api.Object.Commit
tree object =
    Object.single "tree" [] object


treeResourcePath : FieldDecoder String Api.Object.Commit
treeResourcePath =
    Object.fieldDecoder "treeResourcePath" [] Decode.string


treeUrl : FieldDecoder String Api.Object.Commit
treeUrl =
    Object.fieldDecoder "treeUrl" [] Decode.string


url : FieldDecoder String Api.Object.Commit
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanSubscribe : FieldDecoder Bool Api.Object.Commit
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Commit
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder


zipballUrl : FieldDecoder String Api.Object.Commit
zipballUrl =
    Object.fieldDecoder "zipballUrl" [] Decode.string
