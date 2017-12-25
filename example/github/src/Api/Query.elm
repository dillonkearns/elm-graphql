module Api.Query exposing (..)

import Api.Enum.SearchType
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor


codeOfConduct : { key : String } -> SelectionSet codeOfConduct Api.Object.CodeOfConduct -> FieldDecoder codeOfConduct RootQuery
codeOfConduct requiredArgs object =
    Object.single "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object


codesOfConduct : SelectionSet codesOfConduct Api.Object.CodeOfConduct -> FieldDecoder (List codesOfConduct) RootQuery
codesOfConduct object =
    Object.listOf "codesOfConduct" [] object


license : { key : String } -> SelectionSet license Api.Object.License -> FieldDecoder license RootQuery
license requiredArgs object =
    Object.single "license" [ Argument.string "key" requiredArgs.key ] object


licenses : SelectionSet licenses Api.Object.License -> FieldDecoder (List licenses) RootQuery
licenses object =
    Object.listOf "licenses" [] object


marketplaceCategories : ({ excludeEmpty : Maybe Bool } -> { excludeEmpty : Maybe Bool }) -> SelectionSet marketplaceCategories Api.Object.MarketplaceCategory -> FieldDecoder (List marketplaceCategories) RootQuery
marketplaceCategories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { excludeEmpty = Nothing }

        optionalArgs =
            [ Argument.optional "excludeEmpty" filledInOptionals.excludeEmpty Encode.bool ]
                |> List.filterMap identity
    in
    Object.listOf "marketplaceCategories" optionalArgs object


marketplaceCategory : { slug : String } -> SelectionSet marketplaceCategory Api.Object.MarketplaceCategory -> FieldDecoder marketplaceCategory RootQuery
marketplaceCategory requiredArgs object =
    Object.single "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListing : { slug : String } -> SelectionSet marketplaceListing Api.Object.MarketplaceListing -> FieldDecoder marketplaceListing RootQuery
marketplaceListing requiredArgs object =
    Object.single "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListings : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool }) -> SelectionSet marketplaceListings Api.Object.MarketplaceListingConnection -> FieldDecoder marketplaceListings RootQuery
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, categorySlug = Nothing, viewerCanAdmin = Nothing, adminId = Nothing, organizationId = Nothing, allStates = Nothing, slugs = Nothing, primaryCategoryOnly = Nothing, withFreeTrialsOnly = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Encode.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Encode.bool, Argument.optional "adminId" filledInOptionals.adminId Encode.string, Argument.optional "organizationId" filledInOptionals.organizationId Encode.string, Argument.optional "allStates" filledInOptionals.allStates Encode.bool, Argument.optional "slugs" filledInOptionals.slugs (Encode.string |> Encode.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Encode.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "marketplaceListings" optionalArgs object


meta : SelectionSet meta Api.Object.GitHubMetadata -> FieldDecoder meta RootQuery
meta object =
    Object.single "meta" [] object


node : { id : String } -> SelectionSet node Api.Object.Node -> FieldDecoder node RootQuery
node requiredArgs object =
    Object.single "node" [ Argument.string "id" requiredArgs.id ] object


nodes : { ids : String } -> SelectionSet nodes Api.Object.Node -> FieldDecoder (List nodes) RootQuery
nodes requiredArgs object =
    Object.listOf "nodes" [ Argument.string "ids" requiredArgs.ids ] object


organization : { login : String } -> SelectionSet organization Api.Object.Organization -> FieldDecoder organization RootQuery
organization requiredArgs object =
    Object.single "organization" [ Argument.string "login" requiredArgs.login ] object


rateLimit : ({ dryRun : Maybe Bool } -> { dryRun : Maybe Bool }) -> SelectionSet rateLimit Api.Object.RateLimit -> FieldDecoder rateLimit RootQuery
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Nothing }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "rateLimit" optionalArgs object


repository : { owner : String, name : String } -> SelectionSet repository Api.Object.Repository -> FieldDecoder repository RootQuery
repository requiredArgs object =
    Object.single "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object


repositoryOwner : { login : String } -> SelectionSet repositoryOwner Api.Object.RepositoryOwner -> FieldDecoder repositoryOwner RootQuery
repositoryOwner requiredArgs object =
    Object.single "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object


resource : { url : String } -> SelectionSet resource Api.Object.UniformResourceLocatable -> FieldDecoder resource RootQuery
resource requiredArgs object =
    Object.single "resource" [ Argument.string "url" requiredArgs.url ] object


search : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> { query : String, type_ : String } -> SelectionSet search Api.Object.SearchResultItemConnection -> FieldDecoder search RootQuery
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "search" (optionalArgs ++ [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ]) object


topic : { name : String } -> SelectionSet topic Api.Object.Topic -> FieldDecoder topic RootQuery
topic requiredArgs object =
    Object.single "topic" [ Argument.string "name" requiredArgs.name ] object


user : { login : String } -> SelectionSet user Api.Object.User -> FieldDecoder user RootQuery
user requiredArgs object =
    Object.single "user" [ Argument.string "login" requiredArgs.login ] object


viewer : SelectionSet viewer Api.Object.User -> FieldDecoder viewer RootQuery
viewer object =
    Object.single "viewer" [] object
