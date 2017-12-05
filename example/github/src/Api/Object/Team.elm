module Api.Object.Team exposing (..)

import Api.Enum.SubscriptionState
import Api.Enum.TeamPrivacy
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Team
build constructor =
    Object.object constructor


ancestors : Object ancestors Api.Object.TeamConnection -> FieldDecoder ancestors Api.Object.Team
ancestors object =
    Object.single "ancestors" [] object


childTeams : Object childTeams Api.Object.TeamConnection -> FieldDecoder childTeams Api.Object.Team
childTeams object =
    Object.single "childTeams" [] object


combinedSlug : FieldDecoder String Api.Object.Team
combinedSlug =
    Field.fieldDecoder "combinedSlug" [] Decode.string


createdAt : FieldDecoder String Api.Object.Team
createdAt =
    Field.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Team
description =
    Field.fieldDecoder "description" [] Decode.string


editTeamResourcePath : FieldDecoder String Api.Object.Team
editTeamResourcePath =
    Field.fieldDecoder "editTeamResourcePath" [] Decode.string


editTeamUrl : FieldDecoder String Api.Object.Team
editTeamUrl =
    Field.fieldDecoder "editTeamUrl" [] Decode.string


id : FieldDecoder String Api.Object.Team
id =
    Field.fieldDecoder "id" [] Decode.string


invitations : Object invitations Api.Object.OrganizationInvitationConnection -> FieldDecoder invitations Api.Object.Team
invitations object =
    Object.single "invitations" [] object


members : Object members Api.Object.TeamMemberConnection -> FieldDecoder members Api.Object.Team
members object =
    Object.single "members" [] object


membersResourcePath : FieldDecoder String Api.Object.Team
membersResourcePath =
    Field.fieldDecoder "membersResourcePath" [] Decode.string


membersUrl : FieldDecoder String Api.Object.Team
membersUrl =
    Field.fieldDecoder "membersUrl" [] Decode.string


name : FieldDecoder String Api.Object.Team
name =
    Field.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Api.Object.Team
newTeamResourcePath =
    Field.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Api.Object.Team
newTeamUrl =
    Field.fieldDecoder "newTeamUrl" [] Decode.string


organization : Object organization Api.Object.Organization -> FieldDecoder organization Api.Object.Team
organization object =
    Object.single "organization" [] object


parentTeam : Object parentTeam Api.Object.Team -> FieldDecoder parentTeam Api.Object.Team
parentTeam object =
    Object.single "parentTeam" [] object


privacy : FieldDecoder Api.Enum.TeamPrivacy.TeamPrivacy Api.Object.Team
privacy =
    Field.fieldDecoder "privacy" [] Api.Enum.TeamPrivacy.decoder


repositories : Object repositories Api.Object.TeamRepositoryConnection -> FieldDecoder repositories Api.Object.Team
repositories object =
    Object.single "repositories" [] object


repositoriesResourcePath : FieldDecoder String Api.Object.Team
repositoriesResourcePath =
    Field.fieldDecoder "repositoriesResourcePath" [] Decode.string


repositoriesUrl : FieldDecoder String Api.Object.Team
repositoriesUrl =
    Field.fieldDecoder "repositoriesUrl" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Team
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


slug : FieldDecoder String Api.Object.Team
slug =
    Field.fieldDecoder "slug" [] Decode.string


teamsResourcePath : FieldDecoder String Api.Object.Team
teamsResourcePath =
    Field.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Api.Object.Team
teamsUrl =
    Field.fieldDecoder "teamsUrl" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Team
updatedAt =
    Field.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Team
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder String Api.Object.Team
viewerCanAdminister =
    Field.fieldDecoder "viewerCanAdminister" [] Decode.string


viewerCanSubscribe : FieldDecoder String Api.Object.Team
viewerCanSubscribe =
    Field.fieldDecoder "viewerCanSubscribe" [] Decode.string


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Team
viewerSubscription =
    Field.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
