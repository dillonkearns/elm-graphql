module Api.Object.Commit exposing (..)

import Api.Enum.SubscriptionState
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Commit
build constructor =
    Object.object constructor


abbreviatedOid : FieldDecoder String Api.Object.Commit
abbreviatedOid =
    Field.fieldDecoder "abbreviatedOid" [] Decode.string


author : Object author Api.Object.GitActor -> FieldDecoder author Api.Object.Commit
author object =
    Object.single "author" [] object


authoredByCommitter : FieldDecoder String Api.Object.Commit
authoredByCommitter =
    Field.fieldDecoder "authoredByCommitter" [] Decode.string


blame : Object blame Api.Object.Blame -> FieldDecoder blame Api.Object.Commit
blame object =
    Object.single "blame" [] object


comments : Object comments Api.Object.CommitCommentConnection -> FieldDecoder comments Api.Object.Commit
comments object =
    Object.single "comments" [] object


commitResourcePath : FieldDecoder String Api.Object.Commit
commitResourcePath =
    Field.fieldDecoder "commitResourcePath" [] Decode.string


commitUrl : FieldDecoder String Api.Object.Commit
commitUrl =
    Field.fieldDecoder "commitUrl" [] Decode.string


committedDate : FieldDecoder String Api.Object.Commit
committedDate =
    Field.fieldDecoder "committedDate" [] Decode.string


committedViaWeb : FieldDecoder String Api.Object.Commit
committedViaWeb =
    Field.fieldDecoder "committedViaWeb" [] Decode.string


committer : Object committer Api.Object.GitActor -> FieldDecoder committer Api.Object.Commit
committer object =
    Object.single "committer" [] object


history : Object history Api.Object.CommitHistoryConnection -> FieldDecoder history Api.Object.Commit
history object =
    Object.single "history" [] object


id : FieldDecoder String Api.Object.Commit
id =
    Field.fieldDecoder "id" [] Decode.string


message : FieldDecoder String Api.Object.Commit
message =
    Field.fieldDecoder "message" [] Decode.string


messageBody : FieldDecoder String Api.Object.Commit
messageBody =
    Field.fieldDecoder "messageBody" [] Decode.string


messageBodyHTML : FieldDecoder String Api.Object.Commit
messageBodyHTML =
    Field.fieldDecoder "messageBodyHTML" [] Decode.string


messageHeadline : FieldDecoder String Api.Object.Commit
messageHeadline =
    Field.fieldDecoder "messageHeadline" [] Decode.string


messageHeadlineHTML : FieldDecoder String Api.Object.Commit
messageHeadlineHTML =
    Field.fieldDecoder "messageHeadlineHTML" [] Decode.string


oid : FieldDecoder String Api.Object.Commit
oid =
    Field.fieldDecoder "oid" [] Decode.string


parents : Object parents Api.Object.CommitConnection -> FieldDecoder parents Api.Object.Commit
parents object =
    Object.single "parents" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Commit
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Commit
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


signature : Object signature Api.Object.GitSignature -> FieldDecoder signature Api.Object.Commit
signature object =
    Object.single "signature" [] object


status : Object status Api.Object.Status -> FieldDecoder status Api.Object.Commit
status object =
    Object.single "status" [] object


tarballUrl : FieldDecoder String Api.Object.Commit
tarballUrl =
    Field.fieldDecoder "tarballUrl" [] Decode.string


tree : Object tree Api.Object.Tree -> FieldDecoder tree Api.Object.Commit
tree object =
    Object.single "tree" [] object


treeResourcePath : FieldDecoder String Api.Object.Commit
treeResourcePath =
    Field.fieldDecoder "treeResourcePath" [] Decode.string


treeUrl : FieldDecoder String Api.Object.Commit
treeUrl =
    Field.fieldDecoder "treeUrl" [] Decode.string


url : FieldDecoder String Api.Object.Commit
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanSubscribe : FieldDecoder String Api.Object.Commit
viewerCanSubscribe =
    Field.fieldDecoder "viewerCanSubscribe" [] Decode.string


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Commit
viewerSubscription =
    Field.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder


zipballUrl : FieldDecoder String Api.Object.Commit
zipballUrl =
    Field.fieldDecoder "zipballUrl" [] Decode.string
