module Api.Object.RepositoryOwner exposing (..)

import Api.Enum.RepositoryAffiliation
import Api.Enum.RepositoryPrivacy
import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RepositoryOwner
selection constructor =
    Object.object constructor


avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Api.Object.RepositoryOwner
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


id : FieldDecoder String Api.Object.RepositoryOwner
id =
    Object.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.RepositoryOwner
login =
    Object.fieldDecoder "login" [] Decode.string


pinnedRepositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool }) -> SelectionSet pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.RepositoryOwner
pinnedRepositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "pinnedRepositories" optionalArgs object


repositories : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, privacy : OptionalArgument Api.Enum.RepositoryPrivacy.RepositoryPrivacy, orderBy : OptionalArgument Value, affiliations : OptionalArgument (List Api.Enum.RepositoryAffiliation.RepositoryAffiliation), isLocked : OptionalArgument Bool, isFork : OptionalArgument Bool }) -> SelectionSet repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.RepositoryOwner
repositories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, privacy = Absent, orderBy = Absent, affiliations = Absent, isLocked = Absent, isFork = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "privacy" filledInOptionals.privacy (Encode.enum toString), Argument.optional "orderBy" filledInOptionals.orderBy identity, Argument.optional "affiliations" filledInOptionals.affiliations (Encode.enum toString |> Encode.list), Argument.optional "isLocked" filledInOptionals.isLocked Encode.bool, Argument.optional "isFork" filledInOptionals.isFork Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "repositories" optionalArgs object


repository : { name : String } -> SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryOwner
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.RepositoryOwner
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryOwner
url =
    Object.fieldDecoder "url" [] Decode.string
