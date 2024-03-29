-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module GithubNoFormat.Object.Tag exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import GithubNoFormat.Object
import GithubNoFormat.Interface
import GithubNoFormat.Union
import GithubNoFormat.Scalar
import GithubNoFormat.InputObject
import GithubNoFormat.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)

{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : SelectionSet String GithubNoFormat.Object.Tag
abbreviatedOid =
      Object.selectionForField "String" "abbreviatedOid" [] (Decode.string)


{-| The HTTP path for this Git object
-}
commitResourcePath : SelectionSet GithubNoFormat.ScalarCodecs.Uri GithubNoFormat.Object.Tag
commitResourcePath =
      Object.selectionForField "ScalarCodecs.Uri" "commitResourcePath" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| The HTTP URL for this Git object
-}
commitUrl : SelectionSet GithubNoFormat.ScalarCodecs.Uri GithubNoFormat.Object.Tag
commitUrl =
      Object.selectionForField "ScalarCodecs.Uri" "commitUrl" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecUri |> .decoder)


id : SelectionSet GithubNoFormat.ScalarCodecs.Id GithubNoFormat.Object.Tag
id =
      Object.selectionForField "ScalarCodecs.Id" "id" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The Git tag message.
-}
message : SelectionSet (Maybe String) GithubNoFormat.Object.Tag
message =
      Object.selectionForField "(Maybe String)" "message" [] (Decode.string |> Decode.nullable)


{-| The Git tag name.
-}
name : SelectionSet String GithubNoFormat.Object.Tag
name =
      Object.selectionForField "String" "name" [] (Decode.string)


{-| The Git object ID
-}
oid : SelectionSet GithubNoFormat.ScalarCodecs.GitObjectID GithubNoFormat.Object.Tag
oid =
      Object.selectionForField "ScalarCodecs.GitObjectID" "oid" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecGitObjectID |> .decoder)


{-| The Repository the Git object belongs to
-}
repository : SelectionSet decodesTo GithubNoFormat.Object.Repository
 -> SelectionSet decodesTo GithubNoFormat.Object.Tag
repository object____ =
      Object.selectionForCompositeField "repository" [] (object____) (Basics.identity)


{-| Details about the tag author.
-}
tagger : SelectionSet decodesTo GithubNoFormat.Object.GitActor
 -> SelectionSet (Maybe decodesTo) GithubNoFormat.Object.Tag
tagger object____ =
      Object.selectionForCompositeField "tagger" [] (object____) (Basics.identity >> Decode.nullable)


{-| The Git object the tag points to.
-}
target : SelectionSet decodesTo GithubNoFormat.Interface.GitObject
 -> SelectionSet decodesTo GithubNoFormat.Object.Tag
target object____ =
      Object.selectionForCompositeField "target" [] (object____) (Basics.identity)
