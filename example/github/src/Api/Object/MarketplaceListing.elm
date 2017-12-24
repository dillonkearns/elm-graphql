module Api.Object.MarketplaceListing exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.MarketplaceListing
selection constructor =
    Object.object constructor


companyUrl : FieldDecoder String Api.Object.MarketplaceListing
companyUrl =
    Object.fieldDecoder "companyUrl" [] Decode.string


configurationResourcePath : FieldDecoder String Api.Object.MarketplaceListing
configurationResourcePath =
    Object.fieldDecoder "configurationResourcePath" [] Decode.string


configurationUrl : FieldDecoder String Api.Object.MarketplaceListing
configurationUrl =
    Object.fieldDecoder "configurationUrl" [] Decode.string


documentationUrl : FieldDecoder String Api.Object.MarketplaceListing
documentationUrl =
    Object.fieldDecoder "documentationUrl" [] Decode.string


extendedDescription : FieldDecoder String Api.Object.MarketplaceListing
extendedDescription =
    Object.fieldDecoder "extendedDescription" [] Decode.string


extendedDescriptionHTML : FieldDecoder String Api.Object.MarketplaceListing
extendedDescriptionHTML =
    Object.fieldDecoder "extendedDescriptionHTML" [] Decode.string


fullDescription : FieldDecoder String Api.Object.MarketplaceListing
fullDescription =
    Object.fieldDecoder "fullDescription" [] Decode.string


fullDescriptionHTML : FieldDecoder String Api.Object.MarketplaceListing
fullDescriptionHTML =
    Object.fieldDecoder "fullDescriptionHTML" [] Decode.string


hasApprovalBeenRequested : FieldDecoder Bool Api.Object.MarketplaceListing
hasApprovalBeenRequested =
    Object.fieldDecoder "hasApprovalBeenRequested" [] Decode.bool


hasPublishedFreeTrialPlans : FieldDecoder Bool Api.Object.MarketplaceListing
hasPublishedFreeTrialPlans =
    Object.fieldDecoder "hasPublishedFreeTrialPlans" [] Decode.bool


hasTermsOfService : FieldDecoder Bool Api.Object.MarketplaceListing
hasTermsOfService =
    Object.fieldDecoder "hasTermsOfService" [] Decode.bool


howItWorks : FieldDecoder String Api.Object.MarketplaceListing
howItWorks =
    Object.fieldDecoder "howItWorks" [] Decode.string


howItWorksHTML : FieldDecoder String Api.Object.MarketplaceListing
howItWorksHTML =
    Object.fieldDecoder "howItWorksHTML" [] Decode.string


id : FieldDecoder String Api.Object.MarketplaceListing
id =
    Object.fieldDecoder "id" [] Decode.string


installationUrl : FieldDecoder String Api.Object.MarketplaceListing
installationUrl =
    Object.fieldDecoder "installationUrl" [] Decode.string


installedForViewer : FieldDecoder Bool Api.Object.MarketplaceListing
installedForViewer =
    Object.fieldDecoder "installedForViewer" [] Decode.bool


isApproved : FieldDecoder Bool Api.Object.MarketplaceListing
isApproved =
    Object.fieldDecoder "isApproved" [] Decode.bool


isDelisted : FieldDecoder Bool Api.Object.MarketplaceListing
isDelisted =
    Object.fieldDecoder "isDelisted" [] Decode.bool


isDraft : FieldDecoder Bool Api.Object.MarketplaceListing
isDraft =
    Object.fieldDecoder "isDraft" [] Decode.bool


isPaid : FieldDecoder Bool Api.Object.MarketplaceListing
isPaid =
    Object.fieldDecoder "isPaid" [] Decode.bool


isRejected : FieldDecoder Bool Api.Object.MarketplaceListing
isRejected =
    Object.fieldDecoder "isRejected" [] Decode.bool


logoBackgroundColor : FieldDecoder String Api.Object.MarketplaceListing
logoBackgroundColor =
    Object.fieldDecoder "logoBackgroundColor" [] Decode.string


logoUrl : ({ size : Maybe Int } -> { size : Maybe Int }) -> FieldDecoder String Api.Object.MarketplaceListing
logoUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Nothing }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "logoUrl" optionalArgs Decode.string


name : FieldDecoder String Api.Object.MarketplaceListing
name =
    Object.fieldDecoder "name" [] Decode.string


normalizedShortDescription : FieldDecoder String Api.Object.MarketplaceListing
normalizedShortDescription =
    Object.fieldDecoder "normalizedShortDescription" [] Decode.string


pricingUrl : FieldDecoder String Api.Object.MarketplaceListing
pricingUrl =
    Object.fieldDecoder "pricingUrl" [] Decode.string


primaryCategory : SelectionSet primaryCategory Api.Object.MarketplaceCategory -> FieldDecoder primaryCategory Api.Object.MarketplaceListing
primaryCategory object =
    Object.single "primaryCategory" [] object


privacyPolicyUrl : FieldDecoder String Api.Object.MarketplaceListing
privacyPolicyUrl =
    Object.fieldDecoder "privacyPolicyUrl" [] Decode.string


resourcePath : FieldDecoder String Api.Object.MarketplaceListing
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


screenshotUrls : FieldDecoder (List String) Api.Object.MarketplaceListing
screenshotUrls =
    Object.fieldDecoder "screenshotUrls" [] (Decode.string |> Decode.list)


secondaryCategory : SelectionSet secondaryCategory Api.Object.MarketplaceCategory -> FieldDecoder secondaryCategory Api.Object.MarketplaceListing
secondaryCategory object =
    Object.single "secondaryCategory" [] object


shortDescription : FieldDecoder String Api.Object.MarketplaceListing
shortDescription =
    Object.fieldDecoder "shortDescription" [] Decode.string


slug : FieldDecoder String Api.Object.MarketplaceListing
slug =
    Object.fieldDecoder "slug" [] Decode.string


statusUrl : FieldDecoder String Api.Object.MarketplaceListing
statusUrl =
    Object.fieldDecoder "statusUrl" [] Decode.string


supportEmail : FieldDecoder String Api.Object.MarketplaceListing
supportEmail =
    Object.fieldDecoder "supportEmail" [] Decode.string


supportUrl : FieldDecoder String Api.Object.MarketplaceListing
supportUrl =
    Object.fieldDecoder "supportUrl" [] Decode.string


termsOfServiceUrl : FieldDecoder String Api.Object.MarketplaceListing
termsOfServiceUrl =
    Object.fieldDecoder "termsOfServiceUrl" [] Decode.string


url : FieldDecoder String Api.Object.MarketplaceListing
url =
    Object.fieldDecoder "url" [] Decode.string


viewerCanAddPlans : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanAddPlans =
    Object.fieldDecoder "viewerCanAddPlans" [] Decode.bool


viewerCanApprove : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanApprove =
    Object.fieldDecoder "viewerCanApprove" [] Decode.bool


viewerCanDelist : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanDelist =
    Object.fieldDecoder "viewerCanDelist" [] Decode.bool


viewerCanEdit : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanEdit =
    Object.fieldDecoder "viewerCanEdit" [] Decode.bool


viewerCanEditCategories : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanEditCategories =
    Object.fieldDecoder "viewerCanEditCategories" [] Decode.bool


viewerCanEditPlans : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanEditPlans =
    Object.fieldDecoder "viewerCanEditPlans" [] Decode.bool


viewerCanRedraft : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanRedraft =
    Object.fieldDecoder "viewerCanRedraft" [] Decode.bool


viewerCanReject : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanReject =
    Object.fieldDecoder "viewerCanReject" [] Decode.bool


viewerCanRequestApproval : FieldDecoder Bool Api.Object.MarketplaceListing
viewerCanRequestApproval =
    Object.fieldDecoder "viewerCanRequestApproval" [] Decode.bool


viewerHasPurchased : FieldDecoder Bool Api.Object.MarketplaceListing
viewerHasPurchased =
    Object.fieldDecoder "viewerHasPurchased" [] Decode.bool


viewerHasPurchasedForAllOrganizations : FieldDecoder Bool Api.Object.MarketplaceListing
viewerHasPurchasedForAllOrganizations =
    Object.fieldDecoder "viewerHasPurchasedForAllOrganizations" [] Decode.bool


viewerIsListingAdmin : FieldDecoder Bool Api.Object.MarketplaceListing
viewerIsListingAdmin =
    Object.fieldDecoder "viewerIsListingAdmin" [] Decode.bool
