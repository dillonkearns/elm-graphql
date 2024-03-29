-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.ReleaseAsset exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.ScalarCodecs
import Github.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| The asset's content-type
-}
contentType : SelectionSet String Github.Object.ReleaseAsset
contentType =
    Object.selectionForField "String" "contentType" [] Decode.string


{-| Identifies the date and time when the object was created.
-}
createdAt : SelectionSet Github.ScalarCodecs.DateTime Github.Object.ReleaseAsset
createdAt =
    Object.selectionForField "ScalarCodecs.DateTime" "createdAt" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The number of times this asset was downloaded
-}
downloadCount : SelectionSet Int Github.Object.ReleaseAsset
downloadCount =
    Object.selectionForField "Int" "downloadCount" [] Decode.int


{-| Identifies the URL where you can download the release asset via the browser.
-}
downloadUrl : SelectionSet Github.ScalarCodecs.Uri Github.Object.ReleaseAsset
downloadUrl =
    Object.selectionForField "ScalarCodecs.Uri" "downloadUrl" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecUri |> .decoder)


id : SelectionSet Github.ScalarCodecs.Id Github.Object.ReleaseAsset
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| Identifies the title of the release asset.
-}
name : SelectionSet String Github.Object.ReleaseAsset
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| Release that the asset is associated with
-}
release :
    SelectionSet decodesTo Github.Object.Release
    -> SelectionSet (Maybe decodesTo) Github.Object.ReleaseAsset
release object____ =
    Object.selectionForCompositeField "release" [] object____ (Basics.identity >> Decode.nullable)


{-| The size (in bytes) of the asset
-}
size : SelectionSet Int Github.Object.ReleaseAsset
size =
    Object.selectionForField "Int" "size" [] Decode.int


{-| Identifies the date and time when the object was last updated.
@deprecated General type updated timestamps will eventually be replaced by other field specific timestamps. Removal on 2018-07-01 UTC.
-}
updatedAt : SelectionSet Github.ScalarCodecs.DateTime Github.Object.ReleaseAsset
updatedAt =
    Object.selectionForField "ScalarCodecs.DateTime" "updatedAt" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecDateTime |> .decoder)


{-| The user that performed the upload
-}
uploadedBy :
    SelectionSet decodesTo Github.Object.User
    -> SelectionSet decodesTo Github.Object.ReleaseAsset
uploadedBy object____ =
    Object.selectionForCompositeField "uploadedBy" [] object____ Basics.identity


{-| Identifies the URL of the release asset.
-}
url : SelectionSet Github.ScalarCodecs.Uri Github.Object.ReleaseAsset
url =
    Object.selectionForField "ScalarCodecs.Uri" "url" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecUri |> .decoder)
