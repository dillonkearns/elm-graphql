module Github.Object.Repository exposing (..)

import Github.Enum.CollaboratorAffiliation
import Github.Enum.IssueState
import Github.Enum.OrderDirection
import Github.Enum.ProjectState
import Github.Enum.PullRequestState
import Github.Enum.RepositoryAffiliation
import Github.Enum.RepositoryLockReason
import Github.Enum.RepositoryPrivacy
import Github.Enum.SubscriptionState
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Repository
selection constructor =
    Object.selection constructor


{-| A list of users that can be assigned to issues in this repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
assignableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.UserConnection -> FieldDecoder selection Github.Object.Repository
assignableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "assignableUsers" optionalArgs object identity


{-| Returns the code of conduct for this repository
-}
codeOfConduct : SelectionSet selection Github.Object.CodeOfConduct -> FieldDecoder (Maybe selection) Github.Object.Repository
codeOfConduct object =
    Object.selectionFieldDecoder "codeOfConduct" [] object (identity >> Decode.maybe)


{-| A list of collaborators associated with the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - affiliation - Collaborators affiliation level with a repository.

-}
collaborators : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, affiliation : OptionalArgument Github.Enum.CollaboratorAffiliation.CollaboratorAffiliation }) -> SelectionSet selection Github.Object.RepositoryCollaboratorConnection -> FieldDecoder (Maybe selection) Github.Object.Repository
collaborators fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, affiliation = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "affiliation" filledInOptionals.affiliation (Encode.enum Github.Enum.CollaboratorAffiliation.toString) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "collaborators" optionalArgs object (identity >> Decode.maybe)


{-| A list of commit comments associated with the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
commitComments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.CommitCommentConnection -> FieldDecoder selection Github.Object.Repository
commitComments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "commitComments" optionalArgs object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.Repository
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.Repository
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


{-| The Ref associated with the repository's default branch.
-}
defaultBranchRef : SelectionSet selection Github.Object.Ref -> FieldDecoder (Maybe selection) Github.Object.Repository
defaultBranchRef object =
    Object.selectionFieldDecoder "defaultBranchRef" [] object (identity >> Decode.maybe)


{-| A list of protected branches that are on this repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
deployKeys : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.DeployKeyConnection -> FieldDecoder selection Github.Object.Repository
deployKeys fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deployKeys" optionalArgs object identity


{-| Deployments associated with the repository

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - environments - Environments to list deployments for

-}
deployments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, environments : OptionalArgument (List String) }) -> SelectionSet selection Github.Object.DeploymentConnection -> FieldDecoder selection Github.Object.Repository
deployments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, environments = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "environments" filledInOptionals.environments (Encode.string |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "deployments" optionalArgs object identity


{-| The description of the repository.
-}
description : FieldDecoder (Maybe String) Github.Object.Repository
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| The description of the repository rendered to HTML.
-}
descriptionHTML : FieldDecoder String Github.Object.Repository
descriptionHTML =
    Object.fieldDecoder "descriptionHTML" [] Decode.string


{-| The number of kilobytes this repository occupies on disk.
-}
diskUsage : FieldDecoder (Maybe Int) Github.Object.Repository
diskUsage =
    Object.fieldDecoder "diskUsage" [] (Decode.int |> Decode.maybe)


{-| Returns how many forks there are of this repository in the whole network.
-}
forkCount : FieldDecoder Int Github.Object.Repository
forkCount =
    Object.fieldDecoder "forkCount" [] Decode.int


{-| A list of direct forked repositories.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - privacy - If non-null, filters repositories according to privacy
  - orderBy - Ordering options for repositories returned from the connection
  - affiliations - Affiliation options for repositories returned from the connection
  - isLocked - If non-null, filters repositories according to whether they have been locked

-}
forks : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool }) -> SelectionSet selection Github.Object.RepositoryConnection -> FieldDecoder selection Github.Object.Repository
forks fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum Github.Enum.RepositoryPrivacy.toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum Github.Enum.RepositoryAffiliation.toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "forks" optionalArgs object identity


{-| Indicates if the repository has issues feature enabled.
-}
hasIssuesEnabled : FieldDecoder Bool Github.Object.Repository
hasIssuesEnabled =
    Object.fieldDecoder "hasIssuesEnabled" [] Decode.bool


{-| Indicates if the repository has wiki feature enabled.
-}
hasWikiEnabled : FieldDecoder Bool Github.Object.Repository
hasWikiEnabled =
    Object.fieldDecoder "hasWikiEnabled" [] Decode.bool


{-| The repository's URL.
-}
homepageUrl : FieldDecoder (Maybe String) Github.Object.Repository
homepageUrl =
    Object.fieldDecoder "homepageUrl" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.Repository
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Indicates if the repository is unmaintained.
-}
isArchived : FieldDecoder Bool Github.Object.Repository
isArchived =
    Object.fieldDecoder "isArchived" [] Decode.bool


{-| Identifies if the repository is a fork.
-}
isFork : FieldDecoder Bool Github.Object.Repository
isFork =
    Object.fieldDecoder "isFork" [] Decode.bool


{-| Indicates if the repository has been locked or not.
-}
isLocked : FieldDecoder Bool Github.Object.Repository
isLocked =
    Object.fieldDecoder "isLocked" [] Decode.bool


{-| Identifies if the repository is a mirror.
-}
isMirror : FieldDecoder Bool Github.Object.Repository
isMirror =
    Object.fieldDecoder "isMirror" [] Decode.bool


{-| Identifies if the repository is private.
-}
isPrivate : FieldDecoder Bool Github.Object.Repository
isPrivate =
    Object.fieldDecoder "isPrivate" [] Decode.bool


{-| Returns a single issue from the current repository by number.

  - number - The number for the issue to be returned.

-}
issue : { number : Int } -> SelectionSet selection Github.Object.Issue -> FieldDecoder (Maybe selection) Github.Object.Repository
issue requiredArgs object =
    Object.selectionFieldDecoder "issue" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


{-| Returns a single issue-like object from the current repository by number.

  - number - The number for the issue to be returned.

-}
issueOrPullRequest : { number : Int } -> SelectionSet selection Github.Union.IssueOrPullRequest -> FieldDecoder (Maybe selection) Github.Object.Repository
issueOrPullRequest requiredArgs object =
    Object.selectionFieldDecoder "issueOrPullRequest" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


{-| A list of issues that have been opened in the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - labels - A list of label names to filter the pull requests by.
  - orderBy - Ordering options for issues returned from the connection.
  - states - A list of states to filter the issues by.

-}
issues : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, labels : OptionalArgument (List String), orderBy : OptionalArgument Value, states : OptionalArgument (List Github.Enum.IssueState.IssueState) }) -> SelectionSet selection Github.Object.IssueConnection -> FieldDecoder selection Github.Object.Repository
issues fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, labels = Absent, orderBy = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.IssueState.toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "issues" optionalArgs object identity


{-| Returns a single label by name

  - name - Label name

-}
label : { name : String } -> SelectionSet selection Github.Object.Label -> FieldDecoder (Maybe selection) Github.Object.Repository
label requiredArgs object =
    Object.selectionFieldDecoder "label" [ Argument.required "name" requiredArgs.name Encode.string ] object (identity >> Decode.maybe)


{-| A list of labels associated with the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
labels : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.LabelConnection -> FieldDecoder (Maybe selection) Github.Object.Repository
labels fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "labels" optionalArgs object (identity >> Decode.maybe)


{-| A list containing a breakdown of the language composition of the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Order for connection

-}
languages : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet selection Github.Object.LanguageConnection -> FieldDecoder (Maybe selection) Github.Object.Repository
languages fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "languages" optionalArgs object (identity >> Decode.maybe)


{-| The license associated with the repository
-}
license : FieldDecoder (Maybe String) Github.Object.Repository
license =
    Object.fieldDecoder "license" [] (Decode.string |> Decode.maybe)


{-| The license associated with the repository
-}
licenseInfo : SelectionSet selection Github.Object.License -> FieldDecoder (Maybe selection) Github.Object.Repository
licenseInfo object =
    Object.selectionFieldDecoder "licenseInfo" [] object (identity >> Decode.maybe)


{-| The reason the repository has been locked.
-}
lockReason : FieldDecoder (Maybe Github.Enum.RepositoryLockReason.RepositoryLockReason) Github.Object.Repository
lockReason =
    Object.fieldDecoder "lockReason" [] (Github.Enum.RepositoryLockReason.decoder |> Decode.maybe)


{-| A list of Users that can be mentioned in the context of the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
mentionableUsers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.UserConnection -> FieldDecoder selection Github.Object.Repository
mentionableUsers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "mentionableUsers" optionalArgs object identity


{-| Returns a single milestone from the current repository by number.

  - number - The number for the milestone to be returned.

-}
milestone : { number : Int } -> SelectionSet selection Github.Object.Milestone -> FieldDecoder (Maybe selection) Github.Object.Repository
milestone requiredArgs object =
    Object.selectionFieldDecoder "milestone" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


{-| A list of milestones associated with the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
milestones : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.MilestoneConnection -> FieldDecoder (Maybe selection) Github.Object.Repository
milestones fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "milestones" optionalArgs object (identity >> Decode.maybe)


{-| The repository's original mirror URL.
-}
mirrorUrl : FieldDecoder (Maybe String) Github.Object.Repository
mirrorUrl =
    Object.fieldDecoder "mirrorUrl" [] (Decode.string |> Decode.maybe)


{-| The name of the repository.
-}
name : FieldDecoder String Github.Object.Repository
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The repository's name with owner.
-}
nameWithOwner : FieldDecoder String Github.Object.Repository
nameWithOwner =
    Object.fieldDecoder "nameWithOwner" [] Decode.string


{-| A Git object in the repository

  - oid - The Git object ID
  - expression - A Git revision expression suitable for rev-parse

-}
object : ({ oid : OptionalArgument String, expression : OptionalArgument String } -> { oid : OptionalArgument String, expression : OptionalArgument String }) -> SelectionSet selection Github.Interface.GitObject -> FieldDecoder (Maybe selection) Github.Object.Repository
object fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { oid = Absent, expression = Absent }

        optionalArgs =
            [ Argument.optional "oid" filledInOptionals.oid Encode.string, Argument.optional "expression" filledInOptionals.expression Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "object" optionalArgs object (identity >> Decode.maybe)


{-| The User owner of the repository.
-}
owner : SelectionSet selection Github.Interface.RepositoryOwner -> FieldDecoder selection Github.Object.Repository
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


{-| The repository parent, if this is a fork.
-}
parent : SelectionSet selection Github.Object.Repository -> FieldDecoder (Maybe selection) Github.Object.Repository
parent object =
    Object.selectionFieldDecoder "parent" [] object (identity >> Decode.maybe)


{-| The primary language of the repository's code.
-}
primaryLanguage : SelectionSet selection Github.Object.Language -> FieldDecoder (Maybe selection) Github.Object.Repository
primaryLanguage object =
    Object.selectionFieldDecoder "primaryLanguage" [] object (identity >> Decode.maybe)


{-| Find project by number.

  - number - The project number to find.

-}
project : { number : Int } -> SelectionSet selection Github.Object.Project -> FieldDecoder (Maybe selection) Github.Object.Repository
project requiredArgs object =
    Object.selectionFieldDecoder "project" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


{-| A list of projects under the owner.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Ordering options for projects returned from the connection
  - search - Query to search projects by, currently only searching by name.
  - states - A list of states to filter the projects by.

-}
projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet selection Github.Object.ProjectConnection -> FieldDecoder selection Github.Object.Repository
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.ProjectState.toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projects" optionalArgs object identity


{-| The HTTP path listing repository's projects
-}
projectsResourcePath : FieldDecoder String Github.Object.Repository
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


{-| The HTTP URL listing repository's projects
-}
projectsUrl : FieldDecoder String Github.Object.Repository
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


{-| A list of protected branches that are on this repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
protectedBranches : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.ProtectedBranchConnection -> FieldDecoder selection Github.Object.Repository
protectedBranches fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "protectedBranches" optionalArgs object identity


{-| Returns a single pull request from the current repository by number.

  - number - The number for the pull request to be returned.

-}
pullRequest : { number : Int } -> SelectionSet selection Github.Object.PullRequest -> FieldDecoder (Maybe selection) Github.Object.Repository
pullRequest requiredArgs object =
    Object.selectionFieldDecoder "pullRequest" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


{-| A list of pull requests that have been opened in the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - states - A list of states to filter the pull requests by.
  - labels - A list of label names to filter the pull requests by.
  - headRefName - The head ref name to filter the pull requests by.
  - baseRefName - The base ref name to filter the pull requests by.
  - orderBy - Ordering options for pull requests returned from the connection.

-}
pullRequests : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, states : OptionalArgument (List Github.Enum.PullRequestState.PullRequestState), labels : OptionalArgument (List String), headRefName : OptionalArgument String, baseRefName : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet selection Github.Object.PullRequestConnection -> FieldDecoder selection Github.Object.Repository
pullRequests fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, states = Absent, labels = Absent, headRefName = Absent, baseRefName = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.PullRequestState.toString |> Encode.list), Argument.optional "labels" filledInOptionals.labels (Encode.string |> Encode.list), Argument.optional "headRefName" filledInOptionals.headRefName Encode.string, Argument.optional "baseRefName" filledInOptionals.baseRefName Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pullRequests" optionalArgs object identity


{-| Identifies when the repository was last pushed to.
-}
pushedAt : FieldDecoder (Maybe String) Github.Object.Repository
pushedAt =
    Object.fieldDecoder "pushedAt" [] (Decode.string |> Decode.maybe)


{-| Fetch a given ref from the repository

  - qualifiedName - The ref to retrieve.Fully qualified matches are checked in order (`refs/heads/master`) before falling back onto checks for short name matches (`master`).

-}
ref : { qualifiedName : String } -> SelectionSet selection Github.Object.Ref -> FieldDecoder (Maybe selection) Github.Object.Repository
ref requiredArgs object =
    Object.selectionFieldDecoder "ref" [ Argument.required "qualifiedName" requiredArgs.qualifiedName Encode.string ] object (identity >> Decode.maybe)


{-| Fetch a list of refs from the repository

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - refPrefix - A ref name prefix like `refs/heads/`, `refs/tags/`, etc.
  - direction - DEPRECATED: use orderBy. The ordering direction.
  - orderBy - Ordering options for refs returned from the connection.

-}
refs : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, direction : OptionalArgument Github.Enum.OrderDirection.OrderDirection, orderBy : OptionalArgument Value }) -> { refPrefix : String } -> SelectionSet selection Github.Object.RefConnection -> FieldDecoder (Maybe selection) Github.Object.Repository
refs fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, direction = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "direction" filledInOptionals.direction (Encode.enum Github.Enum.OrderDirection.toString), Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "refs" (optionalArgs ++ [ Argument.required "refPrefix" requiredArgs.refPrefix Encode.string ]) object (identity >> Decode.maybe)


{-| Lookup a single release given various criteria.

  - tagName - The name of the Tag the Release was created from

-}
release : { tagName : String } -> SelectionSet selection Github.Object.Release -> FieldDecoder (Maybe selection) Github.Object.Repository
release requiredArgs object =
    Object.selectionFieldDecoder "release" [ Argument.required "tagName" requiredArgs.tagName Encode.string ] object (identity >> Decode.maybe)


{-| List of releases which are dependent on this repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Order for connection

-}
releases : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet selection Github.Object.ReleaseConnection -> FieldDecoder selection Github.Object.Repository
releases fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "releases" optionalArgs object identity


{-| A list of applied repository-topic associations for this repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
repositoryTopics : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.RepositoryTopicConnection -> FieldDecoder selection Github.Object.Repository
repositoryTopics fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "repositoryTopics" optionalArgs object identity


{-| The HTTP path for this repository
-}
resourcePath : FieldDecoder String Github.Object.Repository
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| A description of the repository, rendered to HTML without any links in it.

  - limit - How many characters to return.

-}
shortDescriptionHTML : ({ limit : OptionalArgument Int } -> { limit : OptionalArgument Int }) -> FieldDecoder String Github.Object.Repository
shortDescriptionHTML fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { limit = Absent }

        optionalArgs =
            [ Argument.optional "limit" filledInOptionals.limit Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "shortDescriptionHTML" optionalArgs Decode.string


{-| The SSH URL to clone this repository
-}
sshUrl : FieldDecoder String Github.Object.Repository
sshUrl =
    Object.fieldDecoder "sshUrl" [] Decode.string


{-| A list of users who have starred this starrable.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Order for connection

-}
stargazers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet selection Github.Object.StargazerConnection -> FieldDecoder selection Github.Object.Repository
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "stargazers" optionalArgs object identity


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.Repository
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL for this repository
-}
url : FieldDecoder String Github.Object.Repository
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Indicates whether the viewer has admin permissions on this repository.
-}
viewerCanAdminister : FieldDecoder Bool Github.Object.Repository
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


{-| Can the current viewer create new projects on this owner.
-}
viewerCanCreateProjects : FieldDecoder Bool Github.Object.Repository
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


{-| Check if the viewer is able to change their subscription status for the repository.
-}
viewerCanSubscribe : FieldDecoder Bool Github.Object.Repository
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


{-| Indicates whether the viewer can update the topics of this repository.
-}
viewerCanUpdateTopics : FieldDecoder Bool Github.Object.Repository
viewerCanUpdateTopics =
    Object.fieldDecoder "viewerCanUpdateTopics" [] Decode.bool


{-| Returns a boolean indicating whether the viewing user has starred this starrable.
-}
viewerHasStarred : FieldDecoder Bool Github.Object.Repository
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool


{-| Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
-}
viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Repository
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder


{-| A list of users watching the repository.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
watchers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.UserConnection -> FieldDecoder selection Github.Object.Repository
watchers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "watchers" optionalArgs object identity
