module Api.Query exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Graphqelm.Query as Query
import Json.Decode as Decode exposing (Decoder)


codeOfConduct : { key : String } -> Object codeOfConduct Api.Object.CodeOfConduct -> Field.Query codeOfConduct
codeOfConduct requiredArgs object =
    Object.single "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object
        |> Query.rootQuery


codesOfConduct : Object codesOfConduct Api.Object.CodeOfConduct -> Field.Query (List codesOfConduct)
codesOfConduct object =
    Object.listOf "codesOfConduct" [] object
        |> Query.rootQuery


license : { key : String } -> Object license Api.Object.License -> Field.Query license
license requiredArgs object =
    Object.single "license" [ Argument.string "key" requiredArgs.key ] object
        |> Query.rootQuery


licenses : Object licenses Api.Object.License -> Field.Query (List licenses)
licenses object =
    Object.listOf "licenses" [] object
        |> Query.rootQuery


marketplaceCategories : Field.Query (List String)
marketplaceCategories =
    Field.fieldDecoder "marketplaceCategories" [] (Decode.string |> Decode.list)
        |> Query.rootQuery


marketplaceCategory : { slug : String } -> Object marketplaceCategory Api.Object.MarketplaceCategory -> Field.Query marketplaceCategory
marketplaceCategory requiredArgs object =
    Object.single "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object
        |> Query.rootQuery


marketplaceListing : { slug : String } -> Object marketplaceListing Api.Object.MarketplaceListing -> Field.Query marketplaceListing
marketplaceListing requiredArgs object =
    Object.single "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object
        |> Query.rootQuery


marketplaceListings : Object marketplaceListings Api.Object.MarketplaceListingConnection -> Field.Query marketplaceListings
marketplaceListings object =
    Object.single "marketplaceListings" [] object
        |> Query.rootQuery


meta : Object meta Api.Object.GitHubMetadata -> Field.Query meta
meta object =
    Object.single "meta" [] object
        |> Query.rootQuery


node : { id : String } -> Object node Api.Object.Node -> Field.Query node
node requiredArgs object =
    Object.single "node" [ Argument.string "id" requiredArgs.id ] object
        |> Query.rootQuery


nodes : Object nodes Api.Object.Node -> Field.Query (List nodes)
nodes object =
    Object.listOf "nodes" [] object
        |> Query.rootQuery


organization : { login : String } -> Object organization Api.Object.Organization -> Field.Query organization
organization requiredArgs object =
    Object.single "organization" [ Argument.string "login" requiredArgs.login ] object
        |> Query.rootQuery


rateLimit : Object rateLimit Api.Object.RateLimit -> Field.Query rateLimit
rateLimit object =
    Object.single "rateLimit" [] object
        |> Query.rootQuery


repository : { owner : String, name : String } -> Object repository Api.Object.Repository -> Field.Query repository
repository requiredArgs object =
    Object.single "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object
        |> Query.rootQuery


repositoryOwner : { login : String } -> Object repositoryOwner Api.Object.RepositoryOwner -> Field.Query repositoryOwner
repositoryOwner requiredArgs object =
    Object.single "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object
        |> Query.rootQuery


resource : { url : String } -> Object resource Api.Object.UniformResourceLocatable -> Field.Query resource
resource requiredArgs object =
    Object.single "resource" [ Argument.string "url" requiredArgs.url ] object
        |> Query.rootQuery


search : { query : String, type_ : String } -> Object search Api.Object.SearchResultItemConnection -> Field.Query search
search requiredArgs object =
    Object.single "search" [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ] object
        |> Query.rootQuery


topic : { name : String } -> Object topic Api.Object.Topic -> Field.Query topic
topic requiredArgs object =
    Object.single "topic" [ Argument.string "name" requiredArgs.name ] object
        |> Query.rootQuery


user : { login : String } -> Object user Api.Object.User -> Field.Query user
user requiredArgs object =
    Object.single "user" [ Argument.string "login" requiredArgs.login ] object
        |> Query.rootQuery


viewer : Object viewer Api.Object.User -> Field.Query viewer
viewer object =
    Object.single "viewer" [] object
        |> Query.rootQuery
