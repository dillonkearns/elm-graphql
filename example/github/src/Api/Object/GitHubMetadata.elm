module Api.Object.GitHubMetadata exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object exposing (Object)
import Json.Decode as Decode


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
