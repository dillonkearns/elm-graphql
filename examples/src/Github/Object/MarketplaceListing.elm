module Github.Object.MarketplaceListing exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.MarketplaceListing
selection constructor =
    Object.object constructor


companyUrl : FieldDecoder String Github.Object.MarketplaceListing
companyUrl =
    Object.fieldDecoder "companyUrl" [] Decode.string


configurationResourcePath : FieldDecoder String Github.Object.MarketplaceListing
configurationResourcePath =
    Object.fieldDecoder "configurationResourcePath" [] Decode.string


configurationUrl : FieldDecoder String Github.Object.MarketplaceListing
configurationUrl =
    Object.fieldDecoder "configurationUrl" [] Decode.string


documentationUrl : FieldDecoder String Github.Object.MarketplaceListing
documentationUrl =
    Object.fieldDecoder "documentationUrl" [] Decode.string


extendedDescription : FieldDecoder String Github.Object.MarketplaceListing
extendedDescription =
    Object.fieldDecoder "extendedDescription" [] Decode.string


extendedDescriptionHTML : FieldDecoder String Github.Object.MarketplaceListing
extendedDescriptionHTML =
    Object.fieldDecoder "extendedDescriptionHTML" [] Decode.string


fullDescription : FieldDecoder String Github.Object.MarketplaceListing
fullDescription =
    Object.fieldDecoder "fullDescription" [] Decode.string


fullDescriptionHTML : FieldDecoder String Github.Object.MarketplaceListing
fullDescriptionHTML =
    Object.fieldDecoder "fullDescriptionHTML" [] Decode.string


hasApprovalBeenRequested : FieldDecoder Bool Github.Object.MarketplaceListing
hasApprovalBeenRequested =
    Object.fieldDecoder "hasApprovalBeenRequested" [] Decode.bool


hasPublishedFreeTrialPlans : FieldDecoder Bool Github.Object.MarketplaceListing
hasPublishedFreeTrialPlans =
    Object.fieldDecoder "hasPublishedFreeTrialPlans" [] Decode.bool


hasTermsOfService : FieldDecoder Bool Github.Object.MarketplaceListing
hasTermsOfService =
    Object.fieldDecoder "hasTermsOfService" [] Decode.bool


howItWorks : FieldDecoder String Github.Object.MarketplaceListing
howItWorks =
    Object.fieldDecoder "howItWorks" [] Decode.string


howItWorksHTML : FieldDecoder String Github.Object.MarketplaceListing
howItWorksHTML =
    Object.fieldDecoder "howItWorksHTML" [] Decode.string


id : FieldDecoder String Github.Object.MarketplaceListing
id =
    Object.fieldDecoder "id" [] Decode.string


installationUrl : FieldDecoder String Github.Object.MarketplaceListing
installationUrl =
    Object.fieldDecoder "installationUrl" [] Decode.string


installedForViewer : FieldDecoder Bool Github.Object.MarketplaceListing
installedForViewer =
    Object.fieldDecoder "installedForViewer" [] Decode.bool


isApproved : FieldDecoder Bool Github.Object.MarketplaceListing
isApproved =
    Object.fieldDecoder "isApproved" [] Decode.bool


isDelisted : FieldDecoder Bool Github.Object.MarketplaceListing
isDelisted =
    Object.fieldDecoder "isDelisted" [] Decode.bool


isDraft : FieldDecoder Bool Github.Object.MarketplaceListing
isDraft =
    Object.fieldDecoder "isDraft" [] Decode.bool


isPaid : FieldDecoder Bool Github.Object.MarketplaceListing
isPaid =
    Object.fieldDecoder "isPaid" [] Decode.bool


isRejected : FieldDecoder Bool Github.Object.MarketplaceListing
isRejected =
    Object.fieldDecoder "isRejected" [] Decode.bool


logoBackgroundColor : FieldDecoder String Github.Object.MarketplaceListing
logoBackgroundColor =
    Object.fieldDecoder "logoBackgroundColor" [] Decode.string


logoUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Object.MarketplaceListing
logoUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "logoUrl" optionalArgs Decode.string


name : FieldDecoder String Github.Object.MarketplaceListing
name =
    Object.fieldDecoder "name" [] Decode.string


normalizedShortDescription : FieldDecoder String Github.Object.MarketplaceListing
normalizedShortDescription =
    Object.fieldDecoder "normalizedShortDescription" [] Decode.string


pricingUrl : FieldDecoder String Github.Object.MarketplaceListing
pricingUrl =
    Object.fieldDecoder "pricingUrl" [] Decode.string


primaryCategory : SelectionSet primaryCategory Github.Object.MarketplaceCategory -> FieldDecoder primaryCategory Github.Object.MarketplaceListing
primaryCategory object =
    Object.selectionFieldDecoder "primaryCategory" [] object identity


privacyPolicyUrl : FieldDecoder String Github.Object.MarketplaceListing
privacyPolicyUrl =
    Object.fieldDecoder "privacyPolicyUrl" [] Decode.string


resourcePath : FieldDecoder String Github.Object.MarketplaceListing
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


screenshotUrls : FieldDecoder (List String) Github.Object.MarketplaceListing
screenshotUrls =
    Object.fieldDecoder "screenshotUrls" [] (Decode.string |> Decode.list)


secondaryCategory : SelectionSet secondaryCategory Github.Object.MarketplaceCategory -> FieldDecoder secondaryCategory Github.Object.MarketplaceListing
secondaryCategory object =
    Object.selectionFieldDecoder "secondaryCategory" [] object identity


shortDescription : FieldDecoder String Github.Object.MarketplaceListing
shortDescription =
    Object.fieldDecoder "shortDescription" [] Decode.string


slug : FieldDecoder String Github.Object.MarketplaceListing
slug =
    Object.fieldDecoder "slug" [] Decode.string


statusUrl : FieldDecoder String Github.Object.MarketplaceListing
statusUrl =
    Object.fieldDecoder "statusUrl" [] Decode.string


supportEmail : FieldDecoder String Github.Object.MarketplaceListing
supportEmail =
    Object.fieldDecoder "supportEmail" [] Decode.string


supportUrl : FieldDecoder String Github.Object.MarketplaceListing
supportUrl =
    Object.fieldDecoder "supportUrl" [] Decode.string


termsOfServiceUrl : FieldDecoder String Github.Object.MarketplaceListing
termsOfServiceUrl =
    Object.fieldDecoder "termsOfServiceUrl" [] Decode.string


url : FieldDecoder String Github.Object.MarketplaceListing
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAddPlans : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanAddPlans =
    Object.fieldDecoder "viewerCanAddPlans" [] Decode.bool


viewerCanApprove : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanApprove =
    Object.fieldDecoder "viewerCanApprove" [] Decode.bool


viewerCanDelist : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanDelist =
    Object.fieldDecoder "viewerCanDelist" [] Decode.bool


viewerCanEdit : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanEdit =
    Object.fieldDecoder "viewerCanEdit" [] Decode.bool


viewerCanEditCategories : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanEditCategories =
    Object.fieldDecoder "viewerCanEditCategories" [] Decode.bool


viewerCanEditPlans : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanEditPlans =
    Object.fieldDecoder "viewerCanEditPlans" [] Decode.bool


viewerCanRedraft : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanRedraft =
    Object.fieldDecoder "viewerCanRedraft" [] Decode.bool


viewerCanReject : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanReject =
    Object.fieldDecoder "viewerCanReject" [] Decode.bool


viewerCanRequestApproval : FieldDecoder Bool Github.Object.MarketplaceListing
viewerCanRequestApproval =
    Object.fieldDecoder "viewerCanRequestApproval" [] Decode.bool


viewerHasPurchased : FieldDecoder Bool Github.Object.MarketplaceListing
viewerHasPurchased =
    Object.fieldDecoder "viewerHasPurchased" [] Decode.bool


viewerHasPurchasedForAllOrganizations : FieldDecoder Bool Github.Object.MarketplaceListing
viewerHasPurchasedForAllOrganizations =
    Object.fieldDecoder "viewerHasPurchasedForAllOrganizations" [] Decode.bool


viewerIsListingAdmin : FieldDecoder Bool Github.Object.MarketplaceListing
viewerIsListingAdmin =
    Object.fieldDecoder "viewerIsListingAdmin" [] Decode.bool
