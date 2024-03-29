-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Object.License exposing (..)

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


{-| The full text of the license
-}
body : SelectionSet String Github.Object.License
body =
    Object.selectionForField "String" "body" [] Decode.string


{-| The conditions set by the license
-}
conditions :
    SelectionSet decodesTo Github.Object.LicenseRule
    -> SelectionSet (List (Maybe decodesTo)) Github.Object.License
conditions object____ =
    Object.selectionForCompositeField "conditions" [] object____ (Basics.identity >> Decode.nullable >> Decode.list)


{-| A human-readable description of the license
-}
description : SelectionSet (Maybe String) Github.Object.License
description =
    Object.selectionForField "(Maybe String)" "description" [] (Decode.string |> Decode.nullable)


{-| Whether the license should be featured
-}
featured : SelectionSet Bool Github.Object.License
featured =
    Object.selectionForField "Bool" "featured" [] Decode.bool


{-| Whether the license should be displayed in license pickers
-}
hidden : SelectionSet Bool Github.Object.License
hidden =
    Object.selectionForField "Bool" "hidden" [] Decode.bool


id : SelectionSet Github.ScalarCodecs.Id Github.Object.License
id =
    Object.selectionForField "ScalarCodecs.Id" "id" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| Instructions on how to implement the license
-}
implementation : SelectionSet (Maybe String) Github.Object.License
implementation =
    Object.selectionForField "(Maybe String)" "implementation" [] (Decode.string |> Decode.nullable)


{-| The lowercased SPDX ID of the license
-}
key : SelectionSet String Github.Object.License
key =
    Object.selectionForField "String" "key" [] Decode.string


{-| The limitations set by the license
-}
limitations :
    SelectionSet decodesTo Github.Object.LicenseRule
    -> SelectionSet (List (Maybe decodesTo)) Github.Object.License
limitations object____ =
    Object.selectionForCompositeField "limitations" [] object____ (Basics.identity >> Decode.nullable >> Decode.list)


{-| The license full name specified by <https://spdx.org/licenses>
-}
name : SelectionSet String Github.Object.License
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| Customary short name if applicable (e.g, GPLv3)
-}
nickname : SelectionSet (Maybe String) Github.Object.License
nickname =
    Object.selectionForField "(Maybe String)" "nickname" [] (Decode.string |> Decode.nullable)


{-| The permissions set by the license
-}
permissions :
    SelectionSet decodesTo Github.Object.LicenseRule
    -> SelectionSet (List (Maybe decodesTo)) Github.Object.License
permissions object____ =
    Object.selectionForCompositeField "permissions" [] object____ (Basics.identity >> Decode.nullable >> Decode.list)


{-| Short identifier specified by <https://spdx.org/licenses>
-}
spdxId : SelectionSet (Maybe String) Github.Object.License
spdxId =
    Object.selectionForField "(Maybe String)" "spdxId" [] (Decode.string |> Decode.nullable)


{-| URL to the license on <https://choosealicense.com>
-}
url : SelectionSet (Maybe Github.ScalarCodecs.Uri) Github.Object.License
url =
    Object.selectionForField "(Maybe ScalarCodecs.Uri)" "url" [] (Github.ScalarCodecs.codecs |> Github.Scalar.unwrapCodecs |> .codecUri |> .decoder |> Decode.nullable)
