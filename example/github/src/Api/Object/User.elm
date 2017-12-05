module Api.Object.User exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.User
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.User
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


bio : FieldDecoder String Api.Object.User
bio =
    Field.fieldDecoder "bio" [] Decode.string


bioHTML : FieldDecoder String Api.Object.User
bioHTML =
    Field.fieldDecoder "bioHTML" [] Decode.string


commitComments : Object commitComments Api.Object.CommitCommentConnection -> FieldDecoder commitComments Api.Object.User
commitComments object =
    Object.single "commitComments" [] object


company : FieldDecoder String Api.Object.User
company =
    Field.fieldDecoder "company" [] Decode.string


companyHTML : FieldDecoder String Api.Object.User
companyHTML =
    Field.fieldDecoder "companyHTML" [] Decode.string


contributedRepositories : Object contributedRepositories Api.Object.RepositoryConnection -> FieldDecoder contributedRepositories Api.Object.User
contributedRepositories object =
    Object.single "contributedRepositories" [] object


createdAt : FieldDecoder String Api.Object.User
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


databaseId : FieldDecoder String Api.Object.User
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


email : FieldDecoder String Api.Object.User
email =
    Field.fieldDecoder "email" [] Decode.string


followers : Object followers Api.Object.FollowerConnection -> FieldDecoder followers Api.Object.User
followers object =
    Object.single "followers" [] object


following : Object following Api.Object.FollowingConnection -> FieldDecoder following Api.Object.User
following object =
    Object.single "following" [] object


gist : Object gist Api.Object.Gist -> FieldDecoder gist Api.Object.User
gist object =
    Object.single "gist" [] object


gistComments : Object gistComments Api.Object.GistCommentConnection -> FieldDecoder gistComments Api.Object.User
gistComments object =
    Object.single "gistComments" [] object


gists : Object gists Api.Object.GistConnection -> FieldDecoder gists Api.Object.User
gists object =
    Object.single "gists" [] object


id : FieldDecoder String Api.Object.User
id =
    Field.fieldDecoder "id" [] Decode.string


isBountyHunter : FieldDecoder String Api.Object.User
isBountyHunter =
    Field.fieldDecoder "isBountyHunter" [] Decode.string


isCampusExpert : FieldDecoder String Api.Object.User
isCampusExpert =
    Field.fieldDecoder "isCampusExpert" [] Decode.string


isDeveloperProgramMember : FieldDecoder String Api.Object.User
isDeveloperProgramMember =
    Field.fieldDecoder "isDeveloperProgramMember" [] Decode.string


isEmployee : FieldDecoder String Api.Object.User
isEmployee =
    Field.fieldDecoder "isEmployee" [] Decode.string


isHireable : FieldDecoder String Api.Object.User
isHireable =
    Field.fieldDecoder "isHireable" [] Decode.string


isSiteAdmin : FieldDecoder String Api.Object.User
isSiteAdmin =
    Field.fieldDecoder "isSiteAdmin" [] Decode.string


isViewer : FieldDecoder String Api.Object.User
isViewer =
    Field.fieldDecoder "isViewer" [] Decode.string


issueComments : Object issueComments Api.Object.IssueCommentConnection -> FieldDecoder issueComments Api.Object.User
issueComments object =
    Object.single "issueComments" [] object


issues : Object issues Api.Object.IssueConnection -> FieldDecoder issues Api.Object.User
issues object =
    Object.single "issues" [] object


location : FieldDecoder String Api.Object.User
location =
    Field.fieldDecoder "location" [] Decode.string


login : FieldDecoder String Api.Object.User
login =
    Field.fieldDecoder "login" [] Decode.string


name : FieldDecoder String Api.Object.User
name =
    Field.fieldDecoder "name" [] Decode.string


organization : Object organization Api.Object.Organization -> FieldDecoder organization Api.Object.User
organization object =
    Object.single "organization" [] object


organizations : Object organizations Api.Object.OrganizationConnection -> FieldDecoder organizations Api.Object.User
organizations object =
    Object.single "organizations" [] object


pinnedRepositories : Object pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.User
pinnedRepositories object =
    Object.single "pinnedRepositories" [] object


publicKeys : Object publicKeys Api.Object.PublicKeyConnection -> FieldDecoder publicKeys Api.Object.User
publicKeys object =
    Object.single "publicKeys" [] object


pullRequests : Object pullRequests Api.Object.PullRequestConnection -> FieldDecoder pullRequests Api.Object.User
pullRequests object =
    Object.single "pullRequests" [] object


repositories : Object repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.User
repositories object =
    Object.single "repositories" [] object


repositoriesContributedTo : Object repositoriesContributedTo Api.Object.RepositoryConnection -> FieldDecoder repositoriesContributedTo Api.Object.User
repositoriesContributedTo object =
    Object.single "repositoriesContributedTo" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.User
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.User
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


starredRepositories : Object starredRepositories Api.Object.StarredRepositoryConnection -> FieldDecoder starredRepositories Api.Object.User
starredRepositories object =
    Object.single "starredRepositories" [] object


updatedAt : FieldDecoder String Api.Object.User
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.User
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanFollow : FieldDecoder String Api.Object.User
viewerCanFollow =
    Field.fieldDecoder "viewerCanFollow" [] Decode.string


viewerIsFollowing : FieldDecoder String Api.Object.User
viewerIsFollowing =
    Field.fieldDecoder "viewerIsFollowing" [] Decode.string


watching : Object watching Api.Object.RepositoryConnection -> FieldDecoder watching Api.Object.User
watching object =
    Object.single "watching" [] object


websiteUrl : FieldDecoder String Api.Object.User
websiteUrl =
    Field.fieldDecoder "websiteUrl" [] Decode.string
