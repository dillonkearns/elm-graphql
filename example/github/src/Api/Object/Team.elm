module Api.Object.Team exposing (..)

import Api.Enum.SubscriptionState
import Api.Enum.TeamMemberRole
import Api.Enum.TeamMembershipType
import Api.Enum.TeamPrivacy
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.Team
build constructor =
    Object.object constructor


ancestors : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object ancestors Api.Object.TeamConnection -> FieldDecoder ancestors Api.Object.Team
ancestors fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "ancestors" optionalArgs object


childTeams : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String, userLogins : Maybe (List String), immediateOnly : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, orderBy : Maybe String, userLogins : Maybe (List String), immediateOnly : Maybe Bool }) -> Object childTeams Api.Object.TeamConnection -> FieldDecoder childTeams Api.Object.Team
childTeams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, orderBy = Nothing, userLogins = Nothing, immediateOnly = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "immediateOnly" filledInOptionals.immediateOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "childTeams" optionalArgs object


combinedSlug : FieldDecoder String Api.Object.Team
combinedSlug =
    Object.fieldDecoder "combinedSlug" [] Decode.string


createdAt : FieldDecoder String Api.Object.Team
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Api.Object.Team
description =
    Object.fieldDecoder "description" [] Decode.string


editTeamResourcePath : FieldDecoder String Api.Object.Team
editTeamResourcePath =
    Object.fieldDecoder "editTeamResourcePath" [] Decode.string


editTeamUrl : FieldDecoder String Api.Object.Team
editTeamUrl =
    Object.fieldDecoder "editTeamUrl" [] Decode.string


id : FieldDecoder String Api.Object.Team
id =
    Object.fieldDecoder "id" [] Decode.string


invitations : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> Object invitations Api.Object.OrganizationInvitationConnection -> FieldDecoder invitations Api.Object.Team
invitations fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "invitations" optionalArgs object


members : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, query : Maybe String, membership : Maybe Api.Enum.TeamMembershipType.TeamMembershipType, role : Maybe Api.Enum.TeamMemberRole.TeamMemberRole } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, query : Maybe String, membership : Maybe Api.Enum.TeamMembershipType.TeamMembershipType, role : Maybe Api.Enum.TeamMemberRole.TeamMemberRole }) -> Object members Api.Object.TeamMemberConnection -> FieldDecoder members Api.Object.Team
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, query = Nothing, membership = Nothing, role = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optionalEnum "membership" filledInOptionals.membership, Argument.optionalEnum "role" filledInOptionals.role ]
                |> List.filterMap identity
    in
    Object.single "members" optionalArgs object


membersResourcePath : FieldDecoder String Api.Object.Team
membersResourcePath =
    Object.fieldDecoder "membersResourcePath" [] Decode.string


membersUrl : FieldDecoder String Api.Object.Team
membersUrl =
    Object.fieldDecoder "membersUrl" [] Decode.string


name : FieldDecoder String Api.Object.Team
name =
    Object.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Api.Object.Team
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Api.Object.Team
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


organization : Object organization Api.Object.Organization -> FieldDecoder organization Api.Object.Team
organization object =
    Object.single "organization" [] object


parentTeam : Object parentTeam Api.Object.Team -> FieldDecoder parentTeam Api.Object.Team
parentTeam object =
    Object.single "parentTeam" [] object


privacy : FieldDecoder Api.Enum.TeamPrivacy.TeamPrivacy Api.Object.Team
privacy =
    Object.fieldDecoder "privacy" [] Api.Enum.TeamPrivacy.decoder


repositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, query : Maybe String, orderBy : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, query : Maybe String, orderBy : Maybe String }) -> Object repositories Api.Object.TeamRepositoryConnection -> FieldDecoder repositories Api.Object.Team
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, query = Nothing, orderBy = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy Encode.string ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repositoriesResourcePath : FieldDecoder String Api.Object.Team
repositoriesResourcePath =
    Object.fieldDecoder "repositoriesResourcePath" [] Decode.string


repositoriesUrl : FieldDecoder String Api.Object.Team
repositoriesUrl =
    Object.fieldDecoder "repositoriesUrl" [] Decode.string


resourcePath : FieldDecoder String Api.Object.Team
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


slug : FieldDecoder String Api.Object.Team
slug =
    Object.fieldDecoder "slug" [] Decode.string


teamsResourcePath : FieldDecoder String Api.Object.Team
teamsResourcePath =
    Object.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Api.Object.Team
teamsUrl =
    Object.fieldDecoder "teamsUrl" [] Decode.string


updatedAt : FieldDecoder String Api.Object.Team
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Api.Object.Team
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Api.Object.Team
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Api.Object.Team
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerSubscription : FieldDecoder Api.Enum.SubscriptionState.SubscriptionState Api.Object.Team
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Api.Enum.SubscriptionState.decoder
