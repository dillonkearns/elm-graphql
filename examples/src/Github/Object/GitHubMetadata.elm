module Github.Object.GitHubMetadata exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.GitHubMetadata
selection constructor =
    Object.object constructor


{-| Returns a String that's a SHA of `github-services`
-}
gitHubServicesSha : FieldDecoder String Github.Object.GitHubMetadata
gitHubServicesSha =
    Object.fieldDecoder "gitHubServicesSha" [] Decode.string


{-| IP addresses that users connect to for git operations
-}
gitIpAddresses : FieldDecoder (Maybe (List String)) Github.Object.GitHubMetadata
gitIpAddresses =
    Object.fieldDecoder "gitIpAddresses" [] (Decode.string |> Decode.list |> Decode.maybe)


{-| IP addresses that service hooks are sent from
-}
hookIpAddresses : FieldDecoder (Maybe (List String)) Github.Object.GitHubMetadata
hookIpAddresses =
    Object.fieldDecoder "hookIpAddresses" [] (Decode.string |> Decode.list |> Decode.maybe)


{-| IP addresses that the importer connects from
-}
importerIpAddresses : FieldDecoder (Maybe (List String)) Github.Object.GitHubMetadata
importerIpAddresses =
    Object.fieldDecoder "importerIpAddresses" [] (Decode.string |> Decode.list |> Decode.maybe)


{-| Whether or not users are verified
-}
isPasswordAuthenticationVerifiable : FieldDecoder Bool Github.Object.GitHubMetadata
isPasswordAuthenticationVerifiable =
    Object.fieldDecoder "isPasswordAuthenticationVerifiable" [] Decode.bool


{-| IP addresses for GitHub Pages' A records
-}
pagesIpAddresses : FieldDecoder (Maybe (List String)) Github.Object.GitHubMetadata
pagesIpAddresses =
    Object.fieldDecoder "pagesIpAddresses" [] (Decode.string |> Decode.list |> Decode.maybe)
