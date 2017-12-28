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
    Object.selectionFieldDecoder "codeOfConduct" [ Argument.string "key" requiredArgs.key ] object identity


codesOfConduct : SelectionSet codesOfConduct Github.Object.CodeOfConduct -> FieldDecoder (List codesOfConduct) RootQuery
codesOfConduct object =
    Object.selectionFieldDecoder "codesOfConduct" [] object (identity >> Decode.list)


license : { key : String } -> SelectionSet license Github.Object.License -> FieldDecoder license RootQuery
license requiredArgs object =
    Object.selectionFieldDecoder "license" [ Argument.string "key" requiredArgs.key ] object identity


licenses : SelectionSet licenses Github.Object.License -> FieldDecoder (List licenses) RootQuery
licenses object =
    Object.selectionFieldDecoder "licenses" [] object (identity >> Decode.list)


marketplaceCategories : ({ excludeEmpty : OptionalArgument Bool } -> { excludeEmpty : OptionalArgument Bool }) -> SelectionSet marketplaceCategories Github.Object.MarketplaceCategory -> FieldDecoder (List marketplaceCategories) RootQuery
marketplaceCategories fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { excludeEmpty = Absent }

        optionalArgs =
            [ Argument.optional "excludeEmpty" filledInOptionals.excludeEmpty Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "marketplaceCategories" optionalArgs object (identity >> Decode.list)


marketplaceCategory : { slug : String } -> SelectionSet marketplaceCategory Github.Object.MarketplaceCategory -> FieldDecoder marketplaceCategory RootQuery
marketplaceCategory requiredArgs object =
    Object.selectionFieldDecoder "marketplaceCategory" [ Argument.string "slug" requiredArgs.slug ] object identity


marketplaceListing : { slug : String } -> SelectionSet marketplaceListing Github.Object.MarketplaceListing -> FieldDecoder marketplaceListing RootQuery
marketplaceListing requiredArgs object =
    Object.selectionFieldDecoder "marketplaceListing" [ Argument.string "slug" requiredArgs.slug ] object identity


marketplaceListings : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List String), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List String), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool }) -> SelectionSet marketplaceListings Github.Object.MarketplaceListingConnection -> FieldDecoder marketplaceListings RootQuery
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, categorySlug = Absent, viewerCanAdmin = Absent, adminId = Absent, organizationId = Absent, allStates = Absent, slugs = Absent, primaryCategoryOnly = Absent, withFreeTrialsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Encode.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Encode.bool, Argument.optional "adminId" filledInOptionals.adminId Encode.string, Argument.optional "organizationId" filledInOptionals.organizationId Encode.string, Argument.optional "allStates" filledInOptionals.allStates Encode.bool, Argument.optional "slugs" filledInOptionals.slugs (Encode.string |> Encode.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Encode.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "marketplaceListings" optionalArgs object identity


meta : SelectionSet meta Github.Object.GitHubMetadata -> FieldDecoder meta RootQuery
meta object =
    Object.selectionFieldDecoder "meta" [] object identity


node : { id : String } -> SelectionSet node Github.Object.Node -> FieldDecoder node RootQuery
node requiredArgs object =
    Object.selectionFieldDecoder "node" [ Argument.string "id" requiredArgs.id ] object identity


nodes : { ids : String } -> SelectionSet nodes Github.Object.Node -> FieldDecoder (List nodes) RootQuery
nodes requiredArgs object =
    Object.selectionFieldDecoder "nodes" [ Argument.string "ids" requiredArgs.ids ] object (identity >> Decode.list)


organization : { login : String } -> SelectionSet organization Github.Object.Organization -> FieldDecoder organization RootQuery
organization requiredArgs object =
    Object.selectionFieldDecoder "organization" [ Argument.string "login" requiredArgs.login ] object identity


rateLimit : ({ dryRun : OptionalArgument Bool } -> { dryRun : OptionalArgument Bool }) -> SelectionSet rateLimit Github.Object.RateLimit -> FieldDecoder rateLimit RootQuery
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Absent }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "rateLimit" optionalArgs object identity


relay : SelectionSet relay RootQuery -> FieldDecoder relay RootQuery
relay object =
    Object.selectionFieldDecoder "relay" [] object identity


repository : { owner : String, name : String } -> SelectionSet repository Github.Object.Repository -> FieldDecoder repository RootQuery
repository requiredArgs object =
    Object.selectionFieldDecoder "repository" [ Argument.string "owner" requiredArgs.owner, Argument.string "name" requiredArgs.name ] object identity


repositoryOwner : { login : String } -> SelectionSet repositoryOwner Github.Object.RepositoryOwner -> FieldDecoder repositoryOwner RootQuery
repositoryOwner requiredArgs object =
    Object.selectionFieldDecoder "repositoryOwner" [ Argument.string "login" requiredArgs.login ] object identity


resource : { url : String } -> SelectionSet resource Github.Object.UniformResourceLocatable -> FieldDecoder resource RootQuery
resource requiredArgs object =
    Object.selectionFieldDecoder "resource" [ Argument.string "url" requiredArgs.url ] object identity


search : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> { query : String, type_ : String } -> SelectionSet search Github.Object.SearchResultItemConnection -> FieldDecoder search RootQuery
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "search" (optionalArgs ++ [ Argument.string "query" requiredArgs.query, Argument.string "type" requiredArgs.type_ ]) object identity


topic : { name : String } -> SelectionSet topic Github.Object.Topic -> FieldDecoder topic RootQuery
topic requiredArgs object =
    Object.selectionFieldDecoder "topic" [ Argument.string "name" requiredArgs.name ] object identity


user : { login : String } -> SelectionSet user Github.Object.User -> FieldDecoder user RootQuery
user requiredArgs object =
    Object.selectionFieldDecoder "user" [ Argument.string "login" requiredArgs.login ] object identity


viewer : SelectionSet viewer Github.Object.User -> FieldDecoder viewer RootQuery
viewer object =
    Object.selectionFieldDecoder "viewer" [] object identity
