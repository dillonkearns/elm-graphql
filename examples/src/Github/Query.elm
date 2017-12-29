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


codeOfConduct : { key : String } -> SelectionSet codeOfConduct Github.Object.CodeOfConduct -> FieldDecoder (Maybe codeOfConduct) RootQuery
codeOfConduct requiredArgs object =
    Object.selectionFieldDecoder "codeOfConduct" [ Argument.required "key" (requiredArgs.key |> Encode.string) ] object (identity >> Decode.maybe)


codesOfConduct : SelectionSet codesOfConduct Github.Object.CodeOfConduct -> FieldDecoder (Maybe (List (Maybe codesOfConduct))) RootQuery
codesOfConduct object =
    Object.selectionFieldDecoder "codesOfConduct" [] object (identity >> Decode.maybe >> Decode.list >> Decode.maybe)


license : { key : String } -> SelectionSet license Github.Object.License -> FieldDecoder (Maybe license) RootQuery
license requiredArgs object =
    Object.selectionFieldDecoder "license" [ Argument.required "key" (requiredArgs.key |> Encode.string) ] object (identity >> Decode.maybe)


licenses : SelectionSet licenses Github.Object.License -> FieldDecoder (List (Maybe licenses)) RootQuery
licenses object =
    Object.selectionFieldDecoder "licenses" [] object (identity >> Decode.maybe >> Decode.list)


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


marketplaceCategory : { slug : String } -> SelectionSet marketplaceCategory Github.Object.MarketplaceCategory -> FieldDecoder (Maybe marketplaceCategory) RootQuery
marketplaceCategory requiredArgs object =
    Object.selectionFieldDecoder "marketplaceCategory" [ Argument.required "slug" (requiredArgs.slug |> Encode.string) ] object (identity >> Decode.maybe)


marketplaceListing : { slug : String } -> SelectionSet marketplaceListing Github.Object.MarketplaceListing -> FieldDecoder (Maybe marketplaceListing) RootQuery
marketplaceListing requiredArgs object =
    Object.selectionFieldDecoder "marketplaceListing" [ Argument.required "slug" (requiredArgs.slug |> Encode.string) ] object (identity >> Decode.maybe)


marketplaceListings : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List (Maybe String)), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, categorySlug : OptionalArgument String, viewerCanAdmin : OptionalArgument Bool, adminId : OptionalArgument String, organizationId : OptionalArgument String, allStates : OptionalArgument Bool, slugs : OptionalArgument (List (Maybe String)), primaryCategoryOnly : OptionalArgument Bool, withFreeTrialsOnly : OptionalArgument Bool }) -> SelectionSet marketplaceListings Github.Object.MarketplaceListingConnection -> FieldDecoder marketplaceListings RootQuery
marketplaceListings fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, categorySlug = Absent, viewerCanAdmin = Absent, adminId = Absent, organizationId = Absent, allStates = Absent, slugs = Absent, primaryCategoryOnly = Absent, withFreeTrialsOnly = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "categorySlug" filledInOptionals.categorySlug Encode.string, Argument.optional "viewerCanAdmin" filledInOptionals.viewerCanAdmin Encode.bool, Argument.optional "adminId" filledInOptionals.adminId Encode.string, Argument.optional "organizationId" filledInOptionals.organizationId Encode.string, Argument.optional "allStates" filledInOptionals.allStates Encode.bool, Argument.optional "slugs" filledInOptionals.slugs (Encode.string |> Encode.maybe |> Encode.list), Argument.optional "primaryCategoryOnly" filledInOptionals.primaryCategoryOnly Encode.bool, Argument.optional "withFreeTrialsOnly" filledInOptionals.withFreeTrialsOnly Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "marketplaceListings" optionalArgs object identity


meta : SelectionSet meta Github.Object.GitHubMetadata -> FieldDecoder meta RootQuery
meta object =
    Object.selectionFieldDecoder "meta" [] object identity


node : { id : String } -> SelectionSet node Github.Object.Node -> FieldDecoder (Maybe node) RootQuery
node requiredArgs object =
    Object.selectionFieldDecoder "node" [ Argument.required "id" (requiredArgs.id |> Encode.string) ] object (identity >> Decode.maybe)


nodes : { ids : String } -> SelectionSet nodes Github.Object.Node -> FieldDecoder (List (Maybe nodes)) RootQuery
nodes requiredArgs object =
    Object.selectionFieldDecoder "nodes" [ Argument.required "ids" (requiredArgs.ids |> Encode.string) ] object (identity >> Decode.maybe >> Decode.list)


organization : { login : String } -> SelectionSet organization Github.Object.Organization -> FieldDecoder (Maybe organization) RootQuery
organization requiredArgs object =
    Object.selectionFieldDecoder "organization" [ Argument.required "login" (requiredArgs.login |> Encode.string) ] object (identity >> Decode.maybe)


rateLimit : ({ dryRun : OptionalArgument Bool } -> { dryRun : OptionalArgument Bool }) -> SelectionSet rateLimit Github.Object.RateLimit -> FieldDecoder (Maybe rateLimit) RootQuery
rateLimit fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { dryRun = Absent }

        optionalArgs =
            [ Argument.optional "dryRun" filledInOptionals.dryRun Encode.bool ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "rateLimit" optionalArgs object (identity >> Decode.maybe)


relay : SelectionSet relay RootQuery -> FieldDecoder relay RootQuery
relay object =
    Object.selectionFieldDecoder "relay" [] object identity


repository : { owner : String, name : String } -> SelectionSet repository Github.Object.Repository -> FieldDecoder (Maybe repository) RootQuery
repository requiredArgs object =
    Object.selectionFieldDecoder "repository" [ Argument.required "owner" (requiredArgs.owner |> Encode.string), Argument.required "name" (requiredArgs.name |> Encode.string) ] object (identity >> Decode.maybe)


repositoryOwner : { login : String } -> SelectionSet repositoryOwner Github.Object.RepositoryOwner -> FieldDecoder (Maybe repositoryOwner) RootQuery
repositoryOwner requiredArgs object =
    Object.selectionFieldDecoder "repositoryOwner" [ Argument.required "login" (requiredArgs.login |> Encode.string) ] object (identity >> Decode.maybe)


resource : { url : String } -> SelectionSet resource Github.Object.UniformResourceLocatable -> FieldDecoder (Maybe resource) RootQuery
resource requiredArgs object =
    Object.selectionFieldDecoder "resource" [ Argument.required "url" (requiredArgs.url |> Encode.string) ] object (identity >> Decode.maybe)


search : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> { query : String, type_ : String } -> SelectionSet search Github.Object.SearchResultItemConnection -> FieldDecoder search RootQuery
search fillInOptionals requiredArgs object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "search" (optionalArgs ++ [ Argument.required "query" (requiredArgs.query |> Encode.string), Argument.required "type" (requiredArgs.type_ |> Encode.string) ]) object identity


topic : { name : String } -> SelectionSet topic Github.Object.Topic -> FieldDecoder (Maybe topic) RootQuery
topic requiredArgs object =
    Object.selectionFieldDecoder "topic" [ Argument.required "name" (requiredArgs.name |> Encode.string) ] object (identity >> Decode.maybe)


user : { login : String } -> SelectionSet user Github.Object.User -> FieldDecoder (Maybe user) RootQuery
user requiredArgs object =
    Object.selectionFieldDecoder "user" [ Argument.required "login" (requiredArgs.login |> Encode.string) ] object (identity >> Decode.maybe)


viewer : SelectionSet viewer Github.Object.User -> FieldDecoder viewer RootQuery
viewer object =
    Object.selectionFieldDecoder "viewer" [] object identity
