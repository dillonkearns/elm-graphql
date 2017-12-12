module Api.Query exposing (..)

import Api.Enum.SearchType
import Api.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Builder.RootObject as RootObject
import Graphqelm.Value as Value exposing (Value)
import Json.Decode as Decode exposing (Decoder)


build : (a -> constructor) -> Object (a -> constructor) RootQuery
build constructor =
    RootObject.object constructor


codeOfConduct : { key : String } -> Object codeOfConduct Api.Object.CodeOfConduct -> FieldDecoder codeOfConduct RootQuery
codeOfConduct requiredArgs object =
    RootObject.single "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object


codesOfConduct : Object codesOfConduct Api.Object.CodeOfConduct -> FieldDecoder (List codesOfConduct) RootQuery
codesOfConduct object =
    RootObject.listOf "codesOfConduct" [] object


license : { key : String } -> Object license Api.Object.License -> FieldDecoder license RootQuery
license requiredArgs object =
    RootObject.single "license" [ Argument.string "key" requiredArgs.key ] object


licenses : Object licenses Api.Object.License -> FieldDecoder (List licenses) RootQuery
licenses object =
    RootObject.listOf "licenses" [] object


marketplaceCategories : ({ excludeEmpty : Maybe Bool } -> { excludeEmpty : Maybe Bool }) -> FieldDecoder (List String) RootQuery
marketplaceCategories fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { excludeEmpty = Nothing }

        optionalArgs =
            [ Argument.optional "excludeEmpty" filledInOptionals.excludeEmpty Value.bool ]
                |> List.filterMap identity
    in
    RootObject.fieldDecoder "marketplaceCategories" optionalArgs (Decode.string |> Decode.list)


marketplaceCategory : { slug : String } -> Object marketplaceCategory Api.Object.MarketplaceCategory -> FieldDecoder marketplaceCategory RootQuery
marketplaceCategory requiredArgs object =
    RootObject.single "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListing : { slug : String } -> Object marketplaceListing Api.Object.MarketplaceListing -> FieldDecoder marketplaceListing RootQuery
marketplaceListing requiredArgs object =
    RootObject.single "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListings : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool }) -> Object marketplaceListings Api.Object.MarketplaceListingConnection -> FieldDecoder marketplaceListings RootQuery
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, categorySlug = Nothing, viewerCanAdmin = Nothing, adminId = Nothing, organizationId = Nothing, allStates = Nothing, slugs = Nothing, primaryCategoryOnly = Nothing, withFreeTrialsOnly = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Value.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Value.bool, Argument.optional "adminId" filledInOptionals.adminId Value.string, Argument.optional "organizationId" filledInOptionals.organizationId Value.string, Argument.optional "allStates" filledInOptionals.allStates Value.bool, Argument.optional "slugs" filledInOptionals.slugs (Value.string |> Value.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Value.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Value.bool ]
                |> List.filterMap identity
    in
    RootObject.single "marketplaceListings" optionalArgs object


meta : Object meta Api.Object.GitHubMetadata -> FieldDecoder meta RootQuery
meta object =
    RootObject.single "meta" [] object


node : { id : String } -> Object node Api.Object.Node -> FieldDecoder node RootQuery
node requiredArgs object =
    RootObject.single "node" [ Argument.string "id" requiredArgs.id ] object


nodes : { ids : String } -> Object nodes Api.Object.Node -> FieldDecoder (List nodes) RootQuery
nodes requiredArgs object =
    RootObject.listOf "nodes" [ Argument.string "ids" requiredArgs.ids ] object


organization : { login : String } -> Object organization Api.Object.Organization -> FieldDecoder organization RootQuery
organization requiredArgs object =
    RootObject.single "organization" [ Argument.string "login" requiredArgs.login ] object


rateLimit : ({ dryRun : Maybe Bool } -> { dryRun : Maybe Bool }) -> Object rateLimit Api.Object.RateLimit -> FieldDecoder rateLimit RootQuery
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Nothing }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Value.bool ]
                |> List.filterMap identity
    in
    RootObject.single "rateLimit" optionalArgs object


repository : { owner : String, name : String } -> Object repository Api.Object.Repository -> FieldDecoder repository RootQuery
repository requiredArgs object =
    RootObject.single "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object


repositoryOwner : { login : String } -> Object repositoryOwner Api.Object.RepositoryOwner -> FieldDecoder repositoryOwner RootQuery
repositoryOwner requiredArgs object =
    RootObject.single "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object


resource : { url : String } -> Object resource Api.Object.UniformResourceLocatable -> FieldDecoder resource RootQuery
resource requiredArgs object =
    RootObject.single "resource" [ Argument.string "url" requiredArgs.url ] object


search : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> { query : String, type_ : String } -> Object search Api.Object.SearchResultItemConnection -> FieldDecoder search RootQuery
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    RootObject.single "search" (optionalArgs ++ [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ]) object


topic : { name : String } -> Object topic Api.Object.Topic -> FieldDecoder topic RootQuery
topic requiredArgs object =
    RootObject.single "topic" [ Argument.string "name" requiredArgs.name ] object


user : { login : String } -> Object user Api.Object.User -> FieldDecoder user RootQuery
user requiredArgs object =
    RootObject.single "user" [ Argument.string "login" requiredArgs.login ] object


viewer : Object viewer Api.Object.User -> FieldDecoder viewer RootQuery
viewer object =
    RootObject.single "viewer" [] object
