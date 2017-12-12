module Api.Object.Commit exposing (..)

import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Commit
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Commit
abbreviatedOid =
    Object.fieldDecoder "abbreviatedOid" [] Decode.string


author : Object author Api.Object.GitActor -> FieldDecoder author Api.Object.Commit
author object =
    Object.single "author" [] object


authoredByCommitter : FieldDecoder Bool Api.Object.Commit
authoredByCommitter =
    Object.fieldDecoder "authoredByCommitter" [] Decode.bool


authoredDate : FieldDecoder String Api.Object.Commit
authoredDate =
    Object.fieldDecoder "authoredDate" [] Decode.string


blame : { path : String } -> Object blame Api.Object.Blame -> FieldDecoder blame Api.Object.Commit
blame requiredArgs object =
    Object.single "blame" [ Argument.string "path" requiredArgs.path ] object


comments : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object comments Api.Object.CommitCommentConnection -> FieldDecoder comments Api.Object.Commit
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

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


committer : Object committer Api.Object.GitActor -> FieldDecoder committer Api.Object.Commit
committer object =
    Object.single "committer" [] object


history : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, path : Maybe String, author : Maybe Value, since : Maybe String, until : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, path : Maybe String, author : Maybe Value, since : Maybe String, until : Maybe String }) -> Object history Api.Object.CommitHistoryConnection -> FieldDecoder history Api.Object.Commit
history fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, path = Nothing, author = Nothing, since = Nothing, until = Nothing }

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


parents : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object parents Api.Object.CommitConnection -> FieldDecoder parents Api.Object.Commit
parents fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "parents" optionalArgs object


pushedDate : FieldDecoder String Api.Object.Commit
pushedDate =
    Object.fieldDecoder "pushedDate" [] Decode.string


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Commit
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Commit
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


signature : Object signature Api.Object.GitSignature -> FieldDecoder signature Api.Object.Commit
signature object =
    Object.single "signature" [] object


status : Object status Api.Object.Status -> FieldDecoder status Api.Object.Commit
status object =
    Object.single "status" [] object


tarballUrl : FieldDecoder String Api.Object.Commit
tarballUrl =
    Object.fieldDecoder "tarballUrl" [] Decode.string


tree : Object tree Api.Object.Tree -> FieldDecoder tree Api.Object.Commit
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
