module Github.Query exposing (..)

import Github.Enum.SearchType
import Github.Object
import Graphqelm exposing (RootQuery)
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.object constructor


codeOfConduct : { key : String } -> SelectionSet codeOfConduct Github.Object.CodeOfConduct -> FieldDecoder codeOfConduct RootQuery
codeOfConduct requiredArgs object =
    Object.single "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object


codesOfConduct : SelectionSet codesOfConduct Github.Object.CodeOfConduct -> FieldDecoder (List codesOfConduct) RootQuery
codesOfConduct object =
    Object.listOf "codesOfConduct" [] object


license : { key : String } -> SelectionSet license Github.Object.License -> FieldDecoder license RootQuery
license requiredArgs object =
    Object.single "license" [ Argument.string "key" requiredArgs.key ] object


licenses : SelectionSet licenses Github.Object.License -> FieldDecoder (List licenses) RootQuery
licenses object =
    Object.listOf "licenses" [] object


marketplaceCategories : ({ excludeEmpty : OptionalArgument Bool } -> { excludeEmpty : OptionalArgument Bool }) -> SelectionSet marketplaceCategories Github.Object.MarketplaceCategory -> FieldDecoder (List marketplaceCategories) RootQuery
marketplaceCategories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { excludeEmpty = Absent }

        optionalArgs =
            [ Argument.optional "excludeEmpty" filledInOptionals.excludeEmpty Encode.bool ]
                |> List.filterMap identity
    in
    Object.listOf "marketplaceCategories" optionalArgs object


marketplaceCategory : { slug : String } -> SelectionSet marketplaceCategory Github.Object.MarketplaceCategory -> FieldDecoder marketplaceCategory RootQuery
marketplaceCategory requiredArgs object =
    Object.single "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListing : { slug : String } -> SelectionSet marketplaceListing Github.Object.MarketplaceListing -> FieldDecoder marketplaceListing RootQuery
marketplaceListing requiredArgs object =
    Object.single "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object


marketplaceListings : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List String), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List String), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool }) -> SelectionSet marketplaceListings Github.Object.MarketplaceListingConnection -> FieldDecoder marketplaceListings RootQuery
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, categorySlug = Absent, viewerCanAdmin = Absent, adminId = Absent, organizationId = Absent, allStates = Absent, slugs = Absent, primaryCategoryOnly = Absent, withFreeTrialsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Encode.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Encode.bool, Argument.optional "adminId" filledInOptionals.adminId Encode.string, Argument.optional "organizationId" filledInOptionals.organizationId Encode.string, Argument.optional "allStates" filledInOptionals.allStates Encode.bool, Argument.optional "slugs" filledInOptionals.slugs (Encode.string |> Encode.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Encode.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "marketplaceListings" optionalArgs object


meta : SelectionSet meta Github.Object.GitHubMetadata -> FieldDecoder meta RootQuery
meta object =
    Object.single "meta" [] object


node : { id : String } -> SelectionSet node Github.Object.Node -> FieldDecoder node RootQuery
node requiredArgs object =
    Object.single "node" [ Argument.string "id" requiredArgs.id ] object


nodes : { ids : String } -> SelectionSet nodes Github.Object.Node -> FieldDecoder (List nodes) RootQuery
nodes requiredArgs object =
    Object.listOf "nodes" [ Argument.string "ids" requiredArgs.ids ] object


organization : { login : String } -> SelectionSet organization Github.Object.Organization -> FieldDecoder organization RootQuery
organization requiredArgs object =
    Object.single "organization" [ Argument.string "login" requiredArgs.login ] object


rateLimit : ({ dryRun : OptionalArgument Bool } -> { dryRun : OptionalArgument Bool }) -> SelectionSet rateLimit Github.Object.RateLimit -> FieldDecoder rateLimit RootQuery
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Absent }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Encode.bool ]
                |> List.filterMap identity
    in
    Object.single "rateLimit" optionalArgs object


relay : SelectionSet relay RootQuery -> FieldDecoder relay RootQuery
relay object =
    Object.single "relay" [] object


repository : { owner : String, name : String } -> SelectionSet repository Github.Object.Repository -> FieldDecoder repository RootQuery
repository requiredArgs object =
    Object.single "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object


repositoryOwner : { login : String } -> SelectionSet repositoryOwner Github.Object.RepositoryOwner -> FieldDecoder repositoryOwner RootQuery
repositoryOwner requiredArgs object =
    Object.single "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object


resource : { url : String } -> SelectionSet resource Github.Object.UniformResourceLocatable -> FieldDecoder resource RootQuery
resource requiredArgs object =
    Object.single "resource" [ Argument.string "url" requiredArgs.url ] object


search : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> { query : String, type_ : String } -> SelectionSet search Github.Object.SearchResultItemConnection -> FieldDecoder search RootQuery
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.single "search" (optionalArgs ++ [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ]) object


topic : { name : String } -> SelectionSet topic Github.Object.Topic -> FieldDecoder topic RootQuery
topic requiredArgs object =
    Object.single "topic" [ Argument.string "name" requiredArgs.name ] object


user : { login : String } -> SelectionSet user Github.Object.User -> FieldDecoder user RootQuery
user requiredArgs object =
    Object.single "user" [ Argument.string "login" requiredArgs.login ] object


viewer : SelectionSet viewer Github.Object.User -> FieldDecoder viewer RootQuery
viewer object =
    Object.single "viewer" [] object
