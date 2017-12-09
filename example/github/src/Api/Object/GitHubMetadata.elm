module Api.Object.GitHubMetadata exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode
import Json.Encode as Encode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.GitHubMetadata
build constructor =
    Object.object constructor


gitHubServicesSha : FieldDecoder String Api.Object.GitHubMetadata
gitHubServicesSha =
    Object.fieldDecoder "gitHubServicesSha" [] Decode.string


gitIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
gitIpAddresses =
    Object.fieldDecoder "gitIpAddresses" [] (Decode.string |> Decode.list)


hookIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
hookIpAddresses =
    Object.fieldDecoder "hookIpAddresses" [] (Decode.string |> Decode.list)


importerIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
importerIpAddresses =
    Object.fieldDecoder "importerIpAddresses" [] (Decode.string |> Decode.list)


isPasswordAuthenticationVerifiable : FieldDecoder Bool Api.Object.GitHubMetadata
isPasswordAuthenticationVerifiable =
    Object.fieldDecoder "isPasswordAuthenticationVerifiable" [] Decode.bool


pagesIpAddresses : FieldDecoder (List String) Api.Object.GitHubMetadata
pagesIpAddresses =
    Object.fieldDecoder "pagesIpAddresses" [] (Decode.string |> Decode.list)
