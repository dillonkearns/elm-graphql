module Api.Object.RepositoryOwner exposing (..)

import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryPrivacy
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryOwner
build constructor =
    Object.object constructor


avatarUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.RepositoryOwner
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Value.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


id : FieldDecoder String Api.Object.RepositoryOwner
id =
    Object.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.RepositoryOwner
login =
    Object.fieldDecoder "login" [] Decode.string


pinnedRepositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool }) -> Object pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.RepositoryOwner
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "privacy" filledInOptionals.privacy (Value.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Value.enum toString |> Value.list), Argument.optional "isLocked" filledInOptionals.isLocked Value.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


repositories : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, privacy : Maybe Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : Maybe Value, affiliations : Maybe (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : Maybe Bool, isFork : Maybe Bool }) -> Object repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.RepositoryOwner
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, privacy = Nothing, orderBy = Nothing, affiliations = Nothing, isLocked = Nothing, isFork = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "privacy" filledInOptionals.privacy (Value.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Value.enum toString |> Value.list), Argument.optional "isLocked" filledInOptionals.isLocked Value.bool, Argument.optional "isFork" filledInOptionals.isFork Value.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repository : { name : String } -> Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryOwner
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.RepositoryOwner
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryOwner
url =
    Object.fieldDecoder "url" [] Decode.string
