module Github.Object.Team exposing (..)

import Github.Enum.SubscriptionState
import Github.Enum.TeamMemberRole
import Github.Enum.TeamMembershipType
import Github.Enum.TeamPrivacy
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Team
selection constructor =
    Object.object constructor


ancestors : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet ancestors Github.Object.TeamConnection -> FieldDecoder ancestors Github.Object.Team
ancestors fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "ancestors" optionalArgs object


childTeams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, userLogins : OptionalArgument (List String), immediateOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, userLogins : OptionalArgument (List String), immediateOnly : OptionalArgument Bool }) -> SelectionSet childTeams Github.Object.TeamConnection -> FieldDecoder childTeams Github.Object.Team
childTeams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, userLogins = Absent, immediateOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "immediateOnly" filledInOptionals.immediateOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "childTeams" optionalArgs object


combinedSlug : FieldDecoder String Github.Object.Team
combinedSlug =
    Object.fieldDecoder "combinedSlug" [] Decode.string


createdAt : FieldDecoder String Github.Object.Team
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


description : FieldDecoder String Github.Object.Team
description =
    Object.fieldDecoder "description" [] Decode.string


editTeamResourcePath : FieldDecoder String Github.Object.Team
editTeamResourcePath =
    Object.fieldDecoder "editTeamResourcePath" [] Decode.string


editTeamUrl : FieldDecoder String Github.Object.Team
editTeamUrl =
    Object.fieldDecoder "editTeamUrl" [] Decode.string


id : FieldDecoder String Github.Object.Team
id =
    Object.fieldDecoder "id" [] Decode.string


invitations : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet invitations Github.Object.OrganizationInvitationConnection -> FieldDecoder invitations Github.Object.Team
invitations fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "invitations" optionalArgs object


members : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, membership : OptionalArgument Github.Enum.TeamMembershipType.TeamMembershipType, role : OptionalArgument Github.Enum.TeamMemberRole.TeamMemberRole } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, membership : OptionalArgument Github.Enum.TeamMembershipType.TeamMembershipType, role : OptionalArgument Github.Enum.TeamMemberRole.TeamMemberRole }) -> SelectionSet members Github.Object.TeamMemberConnection -> FieldDecoder members Github.Object.Team
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, query = Absent, membership = Absent, role = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "membership" filledInOptionals.membership (Encode.enum toString), Argument.optional "role" filledInOptionals.role (Encode.enum toString) ]
                |> List.filterMap identity
    in
    Object.single "members" optionalArgs object


membersResourcePath : FieldDecoder String Github.Object.Team
membersResourcePath =
    Object.fieldDecoder "membersResourcePath" [] Decode.string


membersUrl : FieldDecoder String Github.Object.Team
membersUrl =
    Object.fieldDecoder "membersUrl" [] Decode.string


name : FieldDecoder String Github.Object.Team
name =
    Object.fieldDecoder "name" [] Decode.string


newTeamResourcePath : FieldDecoder String Github.Object.Team
newTeamResourcePath =
    Object.fieldDecoder "newTeamResourcePath" [] Decode.string


newTeamUrl : FieldDecoder String Github.Object.Team
newTeamUrl =
    Object.fieldDecoder "newTeamUrl" [] Decode.string


organization : SelectionSet organization Github.Object.Organization -> FieldDecoder organization Github.Object.Team
organization object =
    Object.single "organization" [] object


parentTeam : SelectionSet parentTeam Github.Object.Team -> FieldDecoder parentTeam Github.Object.Team
parentTeam object =
    Object.single "parentTeam" [] object


privacy : FieldDecoder Github.Enum.TeamPrivacy.TeamPrivacy Github.Object.Team
privacy =
    Object.fieldDecoder "privacy" [] Github.Enum.TeamPrivacy.decoder


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet repositories Github.Object.TeamRepositoryConnection -> FieldDecoder repositories Github.Object.Team
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, query = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repositoriesResourcePath : FieldDecoder String Github.Object.Team
repositoriesResourcePath =
    Object.fieldDecoder "repositoriesResourcePath" [] Decode.string


repositoriesUrl : FieldDecoder String Github.Object.Team
repositoriesUrl =
    Object.fieldDecoder "repositoriesUrl" [] Decode.string


resourcePath : FieldDecoder String Github.Object.Team
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


slug : FieldDecoder String Github.Object.Team
slug =
    Object.fieldDecoder "slug" [] Decode.string


teamsResourcePath : FieldDecoder String Github.Object.Team
teamsResourcePath =
    Object.fieldDecoder "teamsResourcePath" [] Decode.string


teamsUrl : FieldDecoder String Github.Object.Team
teamsUrl =
    Object.fieldDecoder "teamsUrl" [] Decode.string


updatedAt : FieldDecoder String Github.Object.Team
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


url : FieldDecoder String Github.Object.Team
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAdminister : FieldDecoder Bool Github.Object.Team
viewerCanAdminister =
    Object.fieldDecoder "viewerCanAdminister" [] Decode.bool


viewerCanSubscribe : FieldDecoder Bool Github.Object.Team
viewerCanSubscribe =
    Object.fieldDecoder "viewerCanSubscribe" [] Decode.bool


viewerSubscription : FieldDecoder Github.Enum.SubscriptionState.SubscriptionState Github.Object.Team
viewerSubscription =
    Object.fieldDecoder "viewerSubscription" [] Github.Enum.SubscriptionState.decoder
