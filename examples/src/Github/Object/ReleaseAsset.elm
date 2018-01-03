module Github.Object.ReleaseAsset exposing (..)

import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReleaseAsset
selection constructor =
    Object.object constructor


{-| The asset's content-type
-}
contentType : FieldDecoder String Github.Object.ReleaseAsset
contentType =
    Object.fieldDecoder "contentType" [] Decode.string


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.ReleaseAsset
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The number of times this asset was downloaded
-}
downloadCount : FieldDecoder Int Github.Object.ReleaseAsset
downloadCount =
    Object.fieldDecoder "downloadCount" [] Decode.int


{-| Identifies the URL where you can download the release asset via the browser.
-}
downloadUrl : FieldDecoder String Github.Object.ReleaseAsset
downloadUrl =
    Object.fieldDecoder "downloadUrl" [] Decode.string


id : FieldDecoder String Github.Object.ReleaseAsset
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Identifies the title of the release asset.
-}
name : FieldDecoder String Github.Object.ReleaseAsset
name =
    Object.fieldDecoder "name" [] Decode.string


{-| Release that the asset is associated with
-}
release : SelectionSet release Github.Object.Release -> FieldDecoder (Maybe release) Github.Object.ReleaseAsset
release object =
    Object.selectionFieldDecoder "release" [] object (identity >> Decode.maybe)


{-| The size (in bytes) of the asset
-}
size : FieldDecoder Int Github.Object.ReleaseAsset
size =
    Object.fieldDecoder "size" [] Decode.int


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.ReleaseAsset
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The user that performed the upload
-}
uploadedBy : SelectionSet uploadedBy Github.Object.User -> FieldDecoder uploadedBy Github.Object.ReleaseAsset
uploadedBy object =
    Object.selectionFieldDecoder "uploadedBy" [] object identity


{-| Identifies the URL of the release asset.
-}
url : FieldDecoder String Github.Object.ReleaseAsset
url =
    Object.fieldDecoder "url" [] Decode.string
