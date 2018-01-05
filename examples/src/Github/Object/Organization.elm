module Github.Object.Organization exposing (..)

import Github.Enum.ProjectState
import Github.Enum.RepositoryAffiliation
import Github.Enum.RepositoryPrivacy
import Github.Enum.TeamPrivacy
import Github.Enum.TeamRole
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Organization
selection constructor =
    Object.selection constructor


{-| A URL pointing to the organization's public avatar.

  - size - The size of the resulting square image.

-}
avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Object.Organization
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.Organization
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


{-| The organization's public profile description.
-}
description : FieldDecoder (Maybe String) Github.Object.Organization
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


{-| The organization's public email.
-}
email : FieldDecoder (Maybe String) Github.Object.Organization
email =
    Object.fieldDecoder "email" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.Organization
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The organization's public profile location.
-}
location : FieldDecoder (Maybe String) Github.Object.Organization
location =
    Object.fieldDecoder "location" [] (Decode.string |> Decode.maybe)


{-| The organization's login name.
-}
login : FieldDecoder String Github.Object.Organization
login =
    Object.fieldDecoder "login" [] Decode.string


{-| A list of users who are members of this organization.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
members : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.UserConnection -> FieldDecoder selection Github.Object.Organization
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "members" optionalArgs object identity


{-| The organization's public profile name.
-}
name : FieldDecoder (Maybe String) Github.Object.Organization
name =
    Object.fieldDecoder "name" [] (Decode.string |> Decode.maybe)


{-| The HTTP path creating a new team
-}
newTeamResourcePath : FieldDecoder String Github.Object.Organization
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


{-| The HTTP URL creating a new team
-}
newTeamUrl : FieldDecoder String Github.Object.Organization
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


{-| The billing email for the organization.
-}
organizationBillingEmail : FieldDecoder (Maybe String) Github.Object.Organization
organizationBillingEmail =
    Object.fieldDecoder "organizationBillingEmail" [] (Decode.string |> Decode.maybe)


{-| A list of repositories this user has pinned to their profile

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - privacy - If non-null, filters repositories according to privacy
  - orderBy - Ordering options for repositories returned from the connection
  - affiliations - Affiliation options for repositories returned from the connection
  - isLocked - If non-null, filters repositories according to whether they have been locked

-}
pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool }) -> SelectionSet selection Github.Object.RepositoryConnection -> FieldDecoder selection Github.Object.Organization
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum Github.Enum.RepositoryPrivacy.toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum Github.Enum.RepositoryAffiliation.toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pinnedRepositories" optionalArgs object identity


{-| Find project by number.

  - number - The project number to find.

-}
project : { number : Int } -> SelectionSet selection Github.Object.Project -> FieldDecoder (Maybe selection) Github.Object.Organization
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
projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet selection Github.Object.ProjectConnection -> FieldDecoder selection Github.Object.Organization
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum Github.Enum.ProjectState.toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projects" optionalArgs object identity


{-| The HTTP path listing organization's projects
-}
projectsResourcePath : FieldDecoder String Github.Object.Organization
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


{-| The HTTP URL listing organization's projects
-}
projectsUrl : FieldDecoder String Github.Object.Organization
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


{-| A list of repositories that the user owns.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - privacy - If non-null, filters repositories according to privacy
  - orderBy - Ordering options for repositories returned from the connection
  - affiliations - Affiliation options for repositories returned from the connection
  - isLocked - If non-null, filters repositories according to whether they have been locked
  - isFork - If non-null, filters repositories according to whether they are forks of another repository

-}
repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet selection Github.Object.RepositoryConnection -> FieldDecoder selection Github.Object.Organization
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum Github.Enum.RepositoryPrivacy.toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum Github.Enum.RepositoryAffiliation.toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "repositories" optionalArgs object identity


{-| Find Repository.

  - name - Name of Repository to find.

-}
repository : { name : String } -> SelectionSet selection Github.Object.Repository -> FieldDecoder (Maybe selection) Github.Object.Organization
repository requiredArgs object =
    Object.selectionFieldDecoder "repository" [ Argument.required "name" requiredArgs.name Encode.string ] object (identity >> Decode.maybe)


{-| The HTTP path for this user
-}
resourcePath : FieldDecoder String Github.Object.Organization
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The Organization's SAML Identity Providers
-}
samlIdentityProvider : SelectionSet selection Github.Object.OrganizationIdentityProvider -> FieldDecoder (Maybe selection) Github.Object.Organization
samlIdentityProvider object =
    Object.selectionFieldDecoder "samlIdentityProvider" [] object (identity >> Decode.maybe)


{-| Find an organization's team by its slug.

  - slug - The name or slug of the team to find.

-}
team : { slug : String } -> SelectionSet selection Github.Object.Team -> FieldDecoder (Maybe selection) Github.Object.Organization
team requiredArgs object =
    Object.selectionFieldDecoder "team" [ Argument.required "slug" requiredArgs.slug Encode.string ] object (identity >> Decode.maybe)


{-| A list of teams in this organization.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - privacy - If non-null, filters teams according to privacy
  - role - If non-null, filters teams according to whether the viewer is an admin or member on team
  - query - If non-null, filters teams with query on team name and team slug
  - userLogins - User logins to filter by
  - orderBy - Ordering options for teams returned from the connection
  - ldapMapped - If true, filters teams that are mapped to an LDAP Group (Enterprise only)
  - rootTeamsOnly - If true, restrict to only root teams

-}
teams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool }) -> SelectionSet selection Github.Object.TeamConnection -> FieldDecoder selection Github.Object.Organization
teams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, role = Absent, query = Absent, userLogins = Absent, orderBy = Absent, ldapMapped = Absent, rootTeamsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum Github.Enum.TeamPrivacy.toString), Argument.optional "role" filledInOptionals.role (Encode.enum Github.Enum.TeamRole.toString), Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "ldapMapped" filledInOptionals.ldapMapped Encode.bool, Argument.optional "rootTeamsOnly" filledInOptionals.rootTeamsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "teams" optionalArgs object identity


{-| The HTTP path listing organization's teams
-}
teamsResourcePath : FieldDecoder String Github.Object.Organization
teamsResourcePath =
    Object.fieldDecoder "teamsResourcePath" [] Decode.string


{-| The HTTP URL listing organization's teams
-}
teamsUrl : FieldDecoder String Github.Object.Organization
teamsUrl =
    Object.fieldDecoder "teamsUrl" [] Decode.string


{-| The HTTP URL for this user
-}
url : FieldDecoder String Github.Object.Organization
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Organization is adminable by the viewer.
-}
viewerCanAdminister : FieldDecoder Bool Github.Object.Organization
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


{-| Can the current viewer create new projects on this owner.
-}
viewerCanCreateProjects : FieldDecoder Bool Github.Object.Organization
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


{-| Viewer can create repositories on this organization
-}
viewerCanCreateRepositories : FieldDecoder Bool Github.Object.Organization
viewerCanCreateRepositories =
    Object.fieldDecoder "viewerCanCreateRepositories" [] Decode.bool


{-| Viewer can create teams on this organization.
-}
viewerCanCreateTeams : FieldDecoder Bool Github.Object.Organization
viewerCanCreateTeams =
    Object.fieldDecoder "viewerCanCreateTeams" [] Decode.bool


{-| Viewer is an active member of this organization.
-}
viewerIsAMember : FieldDecoder Bool Github.Object.Organization
viewerIsAMember =
    Object.fieldDecoder "viewerIsAMember" [] Decode.bool


{-| The organization's public profile URL.
-}
websiteUrl : FieldDecoder (Maybe String) Github.Object.Organization
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] (Decode.string |> Decode.maybe)
