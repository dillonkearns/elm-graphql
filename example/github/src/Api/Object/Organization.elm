module Api.Object.Organization exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Organization
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.Organization
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


databaseId : FieldDecoder String Api.Object.Organization
databaseId =
    Field.fieldDecoder "databaseId" [] Decode.string


description : FieldDecoder String Api.Object.Organization
description =
    Field.fieldDecoder "description" [] Decode.string


email : FieldDecoder String Api.Object.Organization
email =
    Field.fieldDecoder "email" [] Decode.string


id : FieldDecoder String Api.Object.Organization
id =
    Field.fieldDecoder "id" [] Decode.string


location : FieldDecoder String Api.Object.Organization
location =
    Field.fieldDecoder "location" [] Decode.string


login : FieldDecoder String Api.Object.Organization
login =
    Field.fieldDecoder "login" [] Decode.string


members : Object members Api.Object.UserConnection -> FieldDecoder members Api.Object.Organization
members object =
    Object.single "members" [] object


name : FieldDecoder String Api.Object.Organization
name =
    Field.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Api.Object.Organization
newTeamResourcePath =
    Field.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Api.Object.Organization
newTeamUrl =
    Field.fieldDecoder "newTeamUrl" [] Decode.string


organizationBillingEmail : FieldDecoder String Api.Object.Organization
organizationBillingEmail =
    Field.fieldDecoder "organizationBillingEmail" [] Decode.string


pinnedRepositories : Object pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.Organization
pinnedRepositories object =
    Object.single "pinnedRepositories" [] object


project : Object project Api.Object.Project -> FieldDecoder project Api.Object.Organization
project object =
    Object.single "project" [] object


projects : Object projects Api.Object.ProjectConnection -> FieldDecoder projects Api.Object.Organization
projects object =
    Object.single "projects" [] object


projectsResourcePath : FieldDecoder String Api.Object.Organization
projectsResourcePath =
    Field.fieldDecoder "projectsResourcePath" [] Decode.string


projectsUrl : FieldDecoder String Api.Object.Organization
projectsUrl =
    Field.fieldDecoder "projectsUrl" [] Decode.string


repositories : Object repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.Organization
repositories object =
    Object.single "repositories" [] object


repository : Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.Organization
repository object =
    Object.single "repository" [] object


resourcePath : FieldDecoder String Api.Object.Organization
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


samlIdentityProvider : Object samlIdentityProvider Api.Object.OrganizationIdentityProvider -> FieldDecoder samlIdentityProvider Api.Object.Organization
samlIdentityProvider object =
    Object.single "samlIdentityProvider" [] object


team : Object team Api.Object.Team -> FieldDecoder team Api.Object.Organization
team object =
    Object.single "team" [] object


teams : Object teams Api.Object.TeamConnection -> FieldDecoder teams Api.Object.Organization
teams object =
    Object.single "teams" [] object


teamsResourcePath : FieldDecoder String Api.Object.Organization
teamsResourcePath =
    Field.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Api.Object.Organization
teamsUrl =
    Field.fieldDecoder "teamsUrl" [] Decode.string


url : FieldDecoder String Api.Object.Organization
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder String Api.Object.Organization
viewerCanAdminister =
    Field.fieldDecoder "viewerCanAdminister" [] Decode.string


viewerCanCreateProjects : FieldDecoder String Api.Object.Organization
viewerCanCreateProjects =
    Field.fieldDecoder "viewerCanCreateProjects" [] Decode.string


viewerCanCreateRepositories : FieldDecoder String Api.Object.Organization
viewerCanCreateRepositories =
    Field.fieldDecoder "viewerCanCreateRepositories" [] Decode.string


viewerCanCreateTeams : FieldDecoder String Api.Object.Organization
viewerCanCreateTeams =
    Field.fieldDecoder "viewerCanCreateTeams" [] Decode.string


viewerIsAMember : FieldDecoder String Api.Object.Organization
viewerIsAMember =
    Field.fieldDecoder "viewerIsAMember" [] Decode.string


websiteUrl : FieldDecoder String Api.Object.Organization
websiteUrl =
    Field.fieldDecoder "websiteUrl" [] Decode.string
