module Api.Object.Organization exposing (..)

import Api.Enum.ProjectState
import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryPrivacy
import Api.Enum.TeamPrivacy
import Api.Enum.TeamRole
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object exposing (Object)
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Organization
build constructor =
    Object.object constructor


avatarUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.Organization
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

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


members : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object members Api.Object.UserConnection -> FieldDecoder members Api.Object.Organization
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

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


pinnedRepositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> Object pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.Organization
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


project : { number : String } -> Object project Api.Object.Project -> FieldDecoder project Api.Object.Organization
project requiredArgs object =
    Object.single "project" [ Argument.string "number" requiredArgs.number ] object


projects : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe Value, search : Maybe String, states : Maybe (List Api.Enum.ProjectState.ProjectState) }) -> Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Organization
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing, search = Nothing, states = Nothing }

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


repositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool }) -> Object repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.Organization
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing, isFork = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repository : { name : String } -> Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Organization
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.Organization
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


samlIdentityProvider : Object samlIdentityProvider Api.Object.OrganizationIdentityProvider -> FieldDecoder samlIdentityProvider Api.Object.Organization
samlIdentityProvider object =
    Object.single "samlIdentityProvider" [] object


team : { slug : String } -> Object team Api.Object.Team -> FieldDecoder team Api.Object.Organization
team requiredArgs object =
    Object.single "team" [ Argument.string "slug" requiredArgs.slug ] object


teams : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.TeamPrivacy.TeamPrivacy, role : Maybe Api.Enum.TeamRole.TeamRole, query : Maybe String, userLogins : Maybe (List String), orderBy : Maybe Value, ldapMapped : Maybe Bool, rootTeamsOnly : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.TeamPrivacy.TeamPrivacy, role : Maybe Api.Enum.TeamRole.TeamRole, query : Maybe String, userLogins : Maybe (List String), orderBy : Maybe Value, ldapMapped : Maybe Bool, rootTeamsOnly : Maybe Bool }) -> Object teams Api.Object.TeamConnection -> FieldDecoder teams Api.Object.Organization
teams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, role = Nothing, query = Nothing, userLogins = Nothing, orderBy = Nothing, ldapMapped = Nothing, rootTeamsOnly = Nothing }

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
