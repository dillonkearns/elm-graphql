module Github.Object.Organization exposing (..)

import Github.Enum.ProjectState
import Github.Enum.RepositoryAffiliation
import Github.Enum.RepositoryPrivacy
import Github.Enum.TeamPrivacy
import Github.Enum.TeamRole
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Organization
selection constructor =
    Object.object constructor


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


databaseId : FieldDecoder Int Github.Object.Organization
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


description : FieldDecoder String Github.Object.Organization
description =
    Object.fieldDecoder "description" [] Decode.string


email : FieldDecoder String Github.Object.Organization
email =
    Object.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Github.Object.Organization
id =
    Object.fieldDecoder "id" [] Decode.string


location : FieldDecoder String Github.Object.Organization
location =
    Object.fieldDecoder "location" [] Decode.string


login : FieldDecoder String Github.Object.Organization
login =
    Object.fieldDecoder "login" [] Decode.string


members : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet members Github.Object.UserConnection -> FieldDecoder members Github.Object.Organization
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "members" optionalArgs object


name : FieldDecoder String Github.Object.Organization
name =
    Object.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Github.Object.Organization
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Github.Object.Organization
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


organizationBillingEmail : FieldDecoder String Github.Object.Organization
organizationBillingEmail =
    Object.fieldDecoder "organizationBillingEmail" [] Decode.string


pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet pinnedRepositories Github.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Github.Object.Organization
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


project : { number : String } -> SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.Organization
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Github.Object.ProjectConnection -> FieldDecoder projects Github.Object.Organization
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Github.Object.Organization
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Github.Object.Organization
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Github.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet repositories Github.Object.RepositoryConnection -> FieldDecoder repositories Github.Object.Organization
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repository : { name : String } -> SelectionSet repository Github.Object.Repository -> FieldDecoder repository Github.Object.Organization
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Github.Object.Organization
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


samlIdentityProvider : SelectionSet samlIdentityProvider Github.Object.OrganizationIdentityProvider -> FieldDecoder samlIdentityProvider Github.Object.Organization
samlIdentityProvider object =
    Object.single "samlIdentityProvider" [] object


team : { slug : String } -> SelectionSet team Github.Object.Team -> FieldDecoder team Github.Object.Organization
team requiredArgs object =
    Object.single "team" [ Argument.string "slug" requiredArgs.slug ] object


teams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool }) -> SelectionSet teams Github.Object.TeamConnection -> FieldDecoder teams Github.Object.Organization
teams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, role = Absent, query = Absent, userLogins = Absent, orderBy = Absent, ldapMapped = Absent, rootTeamsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "role" filledInOptionals.role (Encode.enum toString), Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "ldapMapped" filledInOptionals.ldapMapped Encode.bool, Argument.optional "rootTeamsOnly" filledInOptionals.rootTeamsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "teams" optionalArgs object


teamsResourcePath : FieldDecoder String Github.Object.Organization
teamsResourcePath =
    Object.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Github.Object.Organization
teamsUrl =
    Object.fieldDecoder "teamsUrl" [] Decode.string


url : FieldDecoder String Github.Object.Organization
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Github.Object.Organization
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanCreateProjects : FieldDecoder Bool Github.Object.Organization
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


viewerCanCreateRepositories : FieldDecoder Bool Github.Object.Organization
viewerCanCreateRepositories =
    Object.fieldDecoder "viewerCanCreateRepositories" [] Decode.bool


viewerCanCreateTeams : FieldDecoder Bool Github.Object.Organization
viewerCanCreateTeams =
    Object.fieldDecoder "viewerCanCreateTeams" [] Decode.bool


viewerIsAMember : FieldDecoder Bool Github.Object.Organization
viewerIsAMember =
    Object.fieldDecoder "viewerIsAMember" [] Decode.bool


websiteUrl : FieldDecoder String Github.Object.Organization
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] Decode.string
