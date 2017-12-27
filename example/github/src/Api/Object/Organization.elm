module Api.Object.Organization exposing (..)

import Api.Enum.ProjectState
import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryPrivacy
import Api.Enum.TeamPrivacy
import Api.Enum.TeamRole
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Organization
selection constructor =
    Object.object constructor


avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Api.Object.Organization
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


databaseId : FieldDecoder Int Api.Object.Organization
databaseId =
    Object.fieldDecoder "databaseId" [] Decode.int


description : FieldDecoder String Api.Object.Organization
description =
    Object.fieldDecoder "description" [] Decode.string


email : FieldDecoder String Api.Object.Organization
email =
    Object.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Api.Object.Organization
id =
    Object.fieldDecoder "id" [] Decode.string


location : FieldDecoder String Api.Object.Organization
location =
    Object.fieldDecoder "location" [] Decode.string


login : FieldDecoder String Api.Object.Organization
login =
    Object.fieldDecoder "login" [] Decode.string


members : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet members Api.Object.UserConnection -> FieldDecoder members Api.Object.Organization
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "members" optionalArgs object


name : FieldDecoder String Api.Object.Organization
name =
    Object.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Api.Object.Organization
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Api.Object.Organization
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


organizationBillingEmail : FieldDecoder String Api.Object.Organization
organizationBillingEmail =
    Object.fieldDecoder "organizationBillingEmail" [] Decode.string


pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.Organization
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


project : { number : String } -> SelectionSet project Api.Object.Project -> FieldDecoder project Api.Object.Organization
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Api.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Api.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Organization
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.single "projects" optionalArgs object


projectsResourcePath : FieldDecoder String Api.Object.Organization
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.Organization
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.Organization
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repository : { name : String } -> SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.Organization
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.Organization
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


samlIdentityProvider : SelectionSet samlIdentityProvider Api.Object.OrganizationIdentityProvider -> FieldDecoder samlIdentityProvider Api.Object.Organization
samlIdentityProvider object =
    Object.single "samlIdentityProvider" [] object


team : { slug : String } -> SelectionSet team Api.Object.Team -> FieldDecoder team Api.Object.Organization
team requiredArgs object =
    Object.single "team" [ Argument.string "slug" requiredArgs.slug ] object


teams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Api.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Api.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool }) -> SelectionSet teams Api.Object.TeamConnection -> FieldDecoder teams Api.Object.Organization
teams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, role = Absent, query = Absent, userLogins = Absent, orderBy = Absent, ldapMapped = Absent, rootTeamsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "role" filledInOptionals.role (Encode.enum toString), Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "ldapMapped" filledInOptionals.ldapMapped Encode.bool, Argument.optional "rootTeamsOnly" filledInOptionals.rootTeamsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "teams" optionalArgs object


teamsResourcePath : FieldDecoder String Api.Object.Organization
teamsResourcePath =
    Object.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Api.Object.Organization
teamsUrl =
    Object.fieldDecoder "teamsUrl" [] Decode.string


url : FieldDecoder String Api.Object.Organization
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Api.Object.Organization
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanCreateProjects : FieldDecoder Bool Api.Object.Organization
viewerCanCreateProjects =
    Object.fieldDecoder "viewerCanCreateProjects" [] Decode.bool


viewerCanCreateRepositories : FieldDecoder Bool Api.Object.Organization
viewerCanCreateRepositories =
    Object.fieldDecoder "viewerCanCreateRepositories" [] Decode.bool


viewerCanCreateTeams : FieldDecoder Bool Api.Object.Organization
viewerCanCreateTeams =
    Object.fieldDecoder "viewerCanCreateTeams" [] Decode.bool


viewerIsAMember : FieldDecoder Bool Api.Object.Organization
viewerIsAMember =
    Object.fieldDecoder "viewerIsAMember" [] Decode.bool


websiteUrl : FieldDecoder String Api.Object.Organization
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] Decode.string
