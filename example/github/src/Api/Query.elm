module Api.Query exposing (..)

import Api.Enum.SearchType
import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Graphqelm.Value as Value
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


codeOfConduct : { key : String } -> Object codeOfConduct Api.Object.CodeOfConduct -> Field.Query codeOfConduct
codeOfConduct requiredArgs object =
    Query.single "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object


codesOfConduct : Object codesOfConduct Api.Object.CodeOfConduct -> Field.Query (List codesOfConduct)
codesOfConduct object =
    Query.listOf "codesOfConduct" [] object


license : { key : String } -> Object license Api.Object.License -> Field.Query license
license requiredArgs object =
    Query.single "license" [ Argument.string "key" requiredArgs.key ] object


licenses : Object licenses Api.Object.License -> Field.Query (List licenses)
licenses object =
    Query.listOf "licenses" [] object


marketplaceCategories : ({ excludeEmpty : Maybe Bool } -> { excludeEmpty : Maybe Bool }) -> Field.Query (List String)
marketplaceCategories fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { excludeEmpty = Nothing }

        optionalArgs =
            [ Argument.optional "excludeEmpty" filledInOptionals.excludeEmpty Value.bool ]
                |> List.filterMap identity
    in
    Query.fieldDecoder "marketplaceCategories" optionalArgs (Decode.string |> Decode.list)


marketplaceCategory : { slug : String } -> Object marketplaceCategory Api.Object.MarketplaceCategory -> Field.Query marketplaceCategory
marketplaceCategory requiredArgs object =
    Query.single "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListing : { slug : String } -> Object marketplaceListing Api.Object.MarketplaceListing -> Field.Query marketplaceListing
marketplaceListing requiredArgs object =
    Query.single "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListings : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String, categorySlug : Maybe String, viewerCanAdmin : Maybe Bool, adminId : Maybe String, organizationId : Maybe String, allStates : Maybe Bool, slugs : Maybe (List String), primaryCategoryOnly : Maybe Bool, withFreeTrialsOnly : Maybe Bool }) -> Object marketplaceListings Api.Object.MarketplaceListingConnection -> Field.Query marketplaceListings
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing, categorySlug = Nothing, viewerCanAdmin = Nothing, adminId = Nothing, organizationId = Nothing, allStates = Nothing, slugs = Nothing, primaryCategoryOnly = Nothing, withFreeTrialsOnly = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Value.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Value.bool, Argument.optional "adminId" filledInOptionals.adminId Value.string, Argument.optional "organizationId" filledInOptionals.organizationId Value.string, Argument.optional "allStates" filledInOptionals.allStates Value.bool, Argument.optional "slugs" filledInOptionals.slugs (Value.string |> Value.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Value.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Value.bool ]
                |> List.filterMap identity
    in
    Query.single "marketplaceListings" optionalArgs object


meta : Object meta Api.Object.GitHubMetadata -> Field.Query meta
meta object =
    Query.single "meta" [] object


node : { id : String } -> Object node Api.Object.Node -> Field.Query node
node requiredArgs object =
    Query.single "node" [ Argument.string "id" requiredArgs.id ] object


nodes : { ids : String } -> Object nodes Api.Object.Node -> Field.Query (List nodes)
nodes requiredArgs object =
    Query.listOf "nodes" [ Argument.string "ids" requiredArgs.ids ] object


organization : { login : String } -> Object organization Api.Object.Organization -> Field.Query organization
organization requiredArgs object =
    Query.single "organization" [ Argument.string "login" requiredArgs.login ] object


rateLimit : ({ dryRun : Maybe Bool } -> { dryRun : Maybe Bool }) -> Object rateLimit Api.Object.RateLimit -> Field.Query rateLimit
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Nothing }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Value.bool ]
                |> List.filterMap identity
    in
    Query.single "rateLimit" optionalArgs object


repository : { owner : String, name : String } -> Object repository Api.Object.Repository -> Field.Query repository
repository requiredArgs object =
    Query.single "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object


repositoryOwner : { login : String } -> Object repositoryOwner Api.Object.RepositoryOwner -> Field.Query repositoryOwner
repositoryOwner requiredArgs object =
    Query.single "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object


resource : { url : String } -> Object resource Api.Object.UniformResourceLocatable -> Field.Query resource
resource requiredArgs object =
    Query.single "resource" [ Argument.string "url" requiredArgs.url ] object


search : ({ first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String } -> { first : Maybe Int, after : Maybe String, last : Maybe Int, before : Maybe String }) -> { query : String, type_ : String } -> Object search Api.Object.SearchResultItemConnection -> Field.Query search
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Nothing, after = Nothing, last = Nothing, before = Nothing }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Value.int, Argument.optional "after" filledInOptionals.after Value.string, Argument.optional "last" filledInOptionals.last Value.int, Argument.optional "before" filledInOptionals.before Value.string ]
                |> List.filterMap identity
    in
    Query.single "search" (optionalArgs ++ [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ]) object


topic : { name : String } -> Object topic Api.Object.Topic -> Field.Query topic
topic requiredArgs object =
    Query.single "topic" [ Argument.string "name" requiredArgs.name ] object


user : { login : String } -> Object user Api.Object.User -> Field.Query user
user requiredArgs object =
    Query.single "user" [ Argument.string "login" requiredArgs.login ] object


viewer : Object viewer Api.Object.User -> Field.Query viewer
viewer object =
    Query.single "viewer" [] object
