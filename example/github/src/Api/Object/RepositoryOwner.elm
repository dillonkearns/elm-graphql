module Api.Object.RepositoryOwner exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.RepositoryOwner
build constructor =
    Object.object constructor


avatarUrl : FieldDecoder String Api.Object.RepositoryOwner
avatarUrl =
    Field.fieldDecoder "avatarUrl" [] Decode.string


id : FieldDecoder String Api.Object.RepositoryOwner
id =
    Field.fieldDecoder "id" [] Decode.string


login : FieldDecoder String Api.Object.RepositoryOwner
login =
    Field.fieldDecoder "login" [] Decode.string


pinnedRepositories : Object pinnedRepositories Api.Object.RepositoryConnection -> FieldDecoder pinnedRepositories Api.Object.RepositoryOwner
pinnedRepositories object =
    Object.single "pinnedRepositories" [] object


repositories : Object repositories Api.Object.RepositoryConnection -> FieldDecoder repositories Api.Object.RepositoryOwner
repositories object =
    Object.single "repositories" [] object


repository : { name : String } -> Object repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryOwner
repository requiredArgs object =
    Object.single "repository" [ Argument.string "name" requiredArgs.name ] object


resourcePath : FieldDecoder String Api.Object.RepositoryOwner
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


url : FieldDecoder String Api.Object.RepositoryOwner
url =
    Field.fieldDecoder "url" [] Decode.string
