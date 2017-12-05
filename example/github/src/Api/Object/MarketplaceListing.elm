module Api.Object.MarketplaceListing exposing (..)

import Api.Object
import Graphqelm.Argument as Argument exposing (Argument)
import Graphqelm.Field as Field exposing (Field, FieldDecoder)
import Graphqelm.Object as Object exposing (Object)
import Json.Decode as Decode


build : (a -> constructor) -> Object (a -> constructor) Api.Object.MarketplaceListing
build constructor =
    Object.object constructor


companyUrl : FieldDecoder String Api.Object.MarketplaceListing
companyUrl =
    Field.fieldDecoder "companyUrl" [] Decode.string


configurationResourcePath : FieldDecoder String Api.Object.MarketplaceListing
configurationResourcePath =
    Field.fieldDecoder "configurationResourcePath" [] Decode.string


configurationUrl : FieldDecoder String Api.Object.MarketplaceListing
configurationUrl =
    Field.fieldDecoder "configurationUrl" [] Decode.string


documentationUrl : FieldDecoder String Api.Object.MarketplaceListing
documentationUrl =
    Field.fieldDecoder "documentationUrl" [] Decode.string


extendedDescription : FieldDecoder String Api.Object.MarketplaceListing
extendedDescription =
    Field.fieldDecoder "extendedDescription" [] Decode.string


extendedDescriptionHTML : FieldDecoder String Api.Object.MarketplaceListing
extendedDescriptionHTML =
    Field.fieldDecoder "extendedDescriptionHTML" [] Decode.string


fullDescription : FieldDecoder String Api.Object.MarketplaceListing
fullDescription =
    Field.fieldDecoder "fullDescription" [] Decode.string


fullDescriptionHTML : FieldDecoder String Api.Object.MarketplaceListing
fullDescriptionHTML =
    Field.fieldDecoder "fullDescriptionHTML" [] Decode.string


hasApprovalBeenRequested : FieldDecoder String Api.Object.MarketplaceListing
hasApprovalBeenRequested =
    Field.fieldDecoder "hasApprovalBeenRequested" [] Decode.string


hasPublishedFreeTrialPlans : FieldDecoder String Api.Object.MarketplaceListing
hasPublishedFreeTrialPlans =
    Field.fieldDecoder "hasPublishedFreeTrialPlans" [] Decode.string


hasTermsOfService : FieldDecoder String Api.Object.MarketplaceListing
hasTermsOfService =
    Field.fieldDecoder "hasTermsOfService" [] Decode.string


howItWorks : FieldDecoder String Api.Object.MarketplaceListing
howItWorks =
    Field.fieldDecoder "howItWorks" [] Decode.string


howItWorksHTML : FieldDecoder String Api.Object.MarketplaceListing
howItWorksHTML =
    Field.fieldDecoder "howItWorksHTML" [] Decode.string


id : FieldDecoder String Api.Object.MarketplaceListing
id =
    Field.fieldDecoder "id" [] Decode.string


installationUrl : FieldDecoder String Api.Object.MarketplaceListing
installationUrl =
    Field.fieldDecoder "installationUrl" [] Decode.string


installedForViewer : FieldDecoder String Api.Object.MarketplaceListing
installedForViewer =
    Field.fieldDecoder "installedForViewer" [] Decode.string


isApproved : FieldDecoder String Api.Object.MarketplaceListing
isApproved =
    Field.fieldDecoder "isApproved" [] Decode.string


isDelisted : FieldDecoder String Api.Object.MarketplaceListing
isDelisted =
    Field.fieldDecoder "isDelisted" [] Decode.string


isDraft : FieldDecoder String Api.Object.MarketplaceListing
isDraft =
    Field.fieldDecoder "isDraft" [] Decode.string


isPaid : FieldDecoder String Api.Object.MarketplaceListing
isPaid =
    Field.fieldDecoder "isPaid" [] Decode.string


isRejected : FieldDecoder String Api.Object.MarketplaceListing
isRejected =
    Field.fieldDecoder "isRejected" [] Decode.string


logoBackgroundColor : FieldDecoder String Api.Object.MarketplaceListing
logoBackgroundColor =
    Field.fieldDecoder "logoBackgroundColor" [] Decode.string


logoUrl : FieldDecoder String Api.Object.MarketplaceListing
logoUrl =
    Field.fieldDecoder "logoUrl" [] Decode.string


name : FieldDecoder String Api.Object.MarketplaceListing
name =
    Field.fieldDecoder "name" [] Decode.string


normalizedShortDescription : FieldDecoder String Api.Object.MarketplaceListing
normalizedShortDescription =
    Field.fieldDecoder "normalizedShortDescription" [] Decode.string


pricingUrl : FieldDecoder String Api.Object.MarketplaceListing
pricingUrl =
    Field.fieldDecoder "pricingUrl" [] Decode.string


primaryCategory : Object primaryCategory Api.Object.MarketplaceCategory -> FieldDecoder primaryCategory Api.Object.MarketplaceListing
primaryCategory object =
    Object.single "primaryCategory" [] object


privacyPolicyUrl : FieldDecoder String Api.Object.MarketplaceListing
privacyPolicyUrl =
    Field.fieldDecoder "privacyPolicyUrl" [] Decode.string


resourcePath : FieldDecoder String Api.Object.MarketplaceListing
resourcePath =
    Field.fieldDecoder "resourcePath" [] Decode.string


screenshotUrls : FieldDecoder (List String) Api.Object.MarketplaceListing
screenshotUrls =
    Field.fieldDecoder "screenshotUrls" [] (Decode.string |> Decode.list)


secondaryCategory : Object secondaryCategory Api.Object.MarketplaceCategory -> FieldDecoder secondaryCategory Api.Object.MarketplaceListing
secondaryCategory object =
    Object.single "secondaryCategory" [] object


shortDescription : FieldDecoder String Api.Object.MarketplaceListing
shortDescription =
    Field.fieldDecoder "shortDescription" [] Decode.string


slug : FieldDecoder String Api.Object.MarketplaceListing
slug =
    Field.fieldDecoder "slug" [] Decode.string


statusUrl : FieldDecoder String Api.Object.MarketplaceListing
statusUrl =
    Field.fieldDecoder "statusUrl" [] Decode.string


supportEmail : FieldDecoder String Api.Object.MarketplaceListing
supportEmail =
    Field.fieldDecoder "supportEmail" [] Decode.string


supportUrl : FieldDecoder String Api.Object.MarketplaceListing
supportUrl =
    Field.fieldDecoder "supportUrl" [] Decode.string


termsOfServiceUrl : FieldDecoder String Api.Object.MarketplaceListing
termsOfServiceUrl =
    Field.fieldDecoder "termsOfServiceUrl" [] Decode.string


url : FieldDecoder String Api.Object.MarketplaceListing
url =
    Field.fieldDecoder "url" [] Decode.string


viewerCanAddPlans : FieldDecoder String Api.Object.MarketplaceListing
viewerCanAddPlans =
    Field.fieldDecoder "viewerCanAddPlans" [] Decode.string


viewerCanApprove : FieldDecoder String Api.Object.MarketplaceListing
viewerCanApprove =
    Field.fieldDecoder "viewerCanApprove" [] Decode.string


viewerCanDelist : FieldDecoder String Api.Object.MarketplaceListing
viewerCanDelist =
    Field.fieldDecoder "viewerCanDelist" [] Decode.string


viewerCanEdit : FieldDecoder String Api.Object.MarketplaceListing
viewerCanEdit =
    Field.fieldDecoder "viewerCanEdit" [] Decode.string


viewerCanEditCategories : FieldDecoder String Api.Object.MarketplaceListing
viewerCanEditCategories =
    Field.fieldDecoder "viewerCanEditCategories" [] Decode.string


viewerCanEditPlans : FieldDecoder String Api.Object.MarketplaceListing
viewerCanEditPlans =
    Field.fieldDecoder "viewerCanEditPlans" [] Decode.string


viewerCanRedraft : FieldDecoder String Api.Object.MarketplaceListing
viewerCanRedraft =
    Field.fieldDecoder "viewerCanRedraft" [] Decode.string


viewerCanReject : FieldDecoder String Api.Object.MarketplaceListing
viewerCanReject =
    Field.fieldDecoder "viewerCanReject" [] Decode.string


viewerCanRequestApproval : FieldDecoder String Api.Object.MarketplaceListing
viewerCanRequestApproval =
    Field.fieldDecoder "viewerCanRequestApproval" [] Decode.string


viewerHasPurchased : FieldDecoder String Api.Object.MarketplaceListing
viewerHasPurchased =
    Field.fieldDecoder "viewerHasPurchased" [] Decode.string


viewerHasPurchasedForAllOrganizations : FieldDecoder String Api.Object.MarketplaceListing
viewerHasPurchasedForAllOrganizations =
    Field.fieldDecoder "viewerHasPurchasedForAllOrganizations" [] Decode.string


viewerIsListingAdmin : FieldDecoder String Api.Object.MarketplaceListing
viewerIsListingAdmin =
    Field.fieldDecoder "viewerIsListingAdmin" [] Decode.string
