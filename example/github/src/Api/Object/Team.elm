module Api.Object.Team exposing (..)

import Api.Enum.SubscriptionState
import Api.Enum.TeamMemberRole
import Api.Enum.TeamMembershipType
import Api.Enum.TeamPrivacy
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Team
selection constructor =
    Object.object constructor


ancestors : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet ancestors Api.Object.TeamConnection -> FieldDecoder ancestors Api.Object.Team
ancestors fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "ancestors" optionalArgs object


childTeams : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, userLogins : OptionalArgument (List String), immediateOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value, userLogins : OptionalArgument (List String), immediateOnly : OptionalArgument Bool }) -> SelectionSet childTeams Api.Object.TeamConnection -> FieldDecoder childTeams Api.Object.Team
childTeams fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent, userLogins = Absent, immediateOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "userLogins" filledInOptionals.userLogins (Encode.string |> Encode.list), Argument.optional "immediateOnly" filledInOptionals.immediateOnly Encode.bool ]
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


invitations : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet invitations Api.Object.OrganizationInvitationConnection -> FieldDecoder invitations Api.Object.Team
invitations fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "invitations" optionalArgs object


members : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, membership : OptionalArgument Api.Enum.TeamMembershipType.TeamMembershipType, role : OptionalArgument Api.Enum.TeamMemberRole.TeamMemberRole } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, membership : OptionalArgument Api.Enum.TeamMembershipType.TeamMembershipType, role : OptionalArgument Api.Enum.TeamMemberRole.TeamMemberRole }) -> SelectionSet members Api.Object.TeamMemberConnection -> FieldDecoder members Api.Object.Team
members fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, query = Absent, membership = Absent, role = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "membership" filledInOptionals.membership (Encode.enum toString), Argument.optional "role" filledInOptionals.role (Encode.enum toString) ]
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


organization : SelectionSet organization Api.Object.Organization -> FieldDecoder organization Api.Object.Team
organization object =
    Object.single "organization" [] object


parentTeam : SelectionSet parentTeam Api.Object.Team -> FieldDecoder parentTeam Api.Object.Team
parentTeam object =
    Object.single "parentTeam" [] object


privacy : FieldDecoder Api.Enum.TeamPrivacy.TeamPrivacy Api.Object.Team
privacy =
    Object.fieldDecoder "privacy" [] Api.Enum.TeamPrivacy.decoder


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, query : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet repositories Api.Object.TeamRepositoryConnection -> FieldDecoder repositories Api.Object.Team
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, query = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "query" filledInOptionals.query Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
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
