module Api.Object.GitHubMetadata exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GitHubMetadata
build constructor =
    Object.object constructor


gitHubServicesSha : FieldDecoder String Api.Object.GitHubMetadata
gitHubServicesSha =
    Field.fieldDecoder "gitHubServicesSha" [] Decode.string


gitIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
gitIpAddresses =
    Field.fieldDecoder "gitIpAddresses" [] (Decode.string |> Decode.list)


hookIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
hookIpAddresses =
    Field.fieldDecoder "hookIpAddresses" [] (Decode.string |> Decode.list)


importerIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
importerIpAddresses =
    Field.fieldDecoder "importerIpAddresses" [] (Decode.string |> Decode.list)


isPasswordAuthenticationVerifiable : FieldDecoder String Api.Object.GitHubMetadata
isPasswordAuthenticationVerifiable =
    Field.fieldDecoder "isPasswordAuthenticationVerifiable" [] Decode.string


pagesIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
pagesIpAddresses =
    Field.fieldDecoder "pagesIpAddresses" [] (Decode.string |> Decode.list)
