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


databaseId : FieldDecoder (Maybe Int) Github.Object.Organization
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


description : FieldDecoder (Maybe String) Github.Object.Organization
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


email : FieldDecoder (Maybe String) Github.Object.Organization
email =
    Object.fieldDecoder "email" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.Organization
id =
    Object.fieldDecoder "id" [] Decode.string


location : FieldDecoder (Maybe String) Github.Object.Organization
location =
    Object.fieldDecoder "location" [] (Decode.string |> Decode.maybe)


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
    Object.selectionFieldDecoder "members" optionalArgs object identity


name : FieldDecoder (Maybe String) Github.Object.Organization
name =
    Object.fieldDecoder "name" [] (Decode.string |> Decode.maybe)


newTeamResourcePath : FieldDecoder String Github.Object.Organization
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Github.Object.Organization
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


organizationBillingEmail : FieldDecoder (Maybe String) Github.Object.Organization
organizationBillingEmail =
    Object.fieldDecoder "organizationBillingEmail" [] (Decode.string |> Decode.maybe)


pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool }) -> SelectionSet pinnedRepositories Github.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Github.Object.Organization
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pinnedRepositories" optionalArgs object identity


project : { number : Int } -> SelectionSet project Github.Object.Project -> FieldDecoder (Maybe project) Github.Object.Organization
project requiredArgs object =
    Object.selectionFieldDecoder "project" [ Argument.required "number" requiredArgs.number Encode.int ] object (identity >> Decode.maybe)


projects : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, search : OptionalArgument String, states : OptionalArgument (List Github.Enum.ProjectState.ProjectState) }) -> SelectionSet projects Github.Object.ProjectConnection -> FieldDecoder projects Github.Object.Organization
projects fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, search = Absent, states = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "search" filledInOptionals.search Encode.string, Argument.optional "states" filledInOptionals.states (Encode.enum toString |> Encode.list) ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "projects" optionalArgs object identity


projectsResourcePath : FieldDecoder String Github.Object.Organization
projectsResourcePath =
    Object.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Github.Object.Organization
projectsUrl =
    Object.fieldDecoder "projectsUrl" [] Decode.string


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List (Maybe Github.Enum.RepositoryAffiliation.RepositoryAffiliation)), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet repositories Github.Object.RepositoryConnection -> FieldDecoder repositories Github.Object.Organization
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.maybe |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "repositories" optionalArgs object identity


repository : { name : String } -> SelectionSet repository Github.Object.Repository -> FieldDecoder (Maybe repository) Github.Object.Organization
repository requiredArgs object =
    Object.selectionFieldDecoder "repository" [ Argument.required "name" requiredArgs.name Encode.string ] object (identity >> Decode.maybe)


resourcePath : FieldDecoder String Github.Object.Organization
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


samlIdentityProvider : SelectionSet samlIdentityProvider Github.Object.OrganizationIdentityProvider -> FieldDecoder (Maybe samlIdentityProvider) Github.Object.Organization
samlIdentityProvider object =
    Object.selectionFieldDecoder "samlIdentityProvider" [] object (identity >> Decode.maybe)


team : { slug : String } -> SelectionSet team Github.Object.Team -> FieldDecoder (Maybe team) Github.Object.Organization
team requiredArgs object =
    Object.selectionFieldDecoder "team" [ Argument.required "slug" requiredArgs.slug Encode.string ] object (identity >> Decode.maybe)


teams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Github.Enum.TeamPrivacy.TeamPrivacy, role : OptionalArgument Github.Enum.TeamRole.TeamRole, query : OptionalArgument String, userLogins : OptionalArgument (List String), orderBy : OptionalArgument Value, ldapMapped : OptionalArgument Bool, rootTeamsOnly : OptionalArgument Bool }) -> SelectionSet teams Github.Object.TeamConnection -> FieldDecoder teams Github.Object.Organization
teams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, role = Absent, query = Absent, userLogins = Absent, orderBy = Absent, ldapMapped = Absent, rootTeamsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "role" filledInOptionals.role (Encode.enum toString), Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "ldapMapped" filledInOptionals.ldapMapped Encode.bool, Argument.optional "rootTeamsOnly" filledInOptionals.rootTeamsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "teams" optionalArgs object identity


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


websiteUrl : FieldDecoder (Maybe String) Github.Object.Organization
websiteUrl =
    Object.fieldDecoder "websiteUrl" [] (Decode.string |> Decode.maybe)
