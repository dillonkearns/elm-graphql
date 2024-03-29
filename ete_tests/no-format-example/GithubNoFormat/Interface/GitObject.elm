-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module GithubNoFormat.Interface.GitObject exposing (..)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.SelectionSet exposing (FragmentSelectionSet(..), SelectionSet(..))
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import GithubNoFormat.Object
import GithubNoFormat.Interface
import GithubNoFormat.Union
import GithubNoFormat.Scalar
import GithubNoFormat.InputObject
import GithubNoFormat.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)


type alias Fragments decodesTo =
    {
    onBlob : SelectionSet decodesTo GithubNoFormat.Object.Blob,
 onCommit : SelectionSet decodesTo GithubNoFormat.Object.Commit,
 onTag : SelectionSet decodesTo GithubNoFormat.Object.Tag,
 onTree : SelectionSet decodesTo GithubNoFormat.Object.Tree
    }


{-| Build an exhaustive selection of type-specific fragments.
-}
fragments :
      Fragments decodesTo
      -> SelectionSet decodesTo GithubNoFormat.Interface.GitObject
fragments selections____ =
    Object.exhaustiveFragmentSelection
        [
         Object.buildFragment "Blob" selections____.onBlob,
 Object.buildFragment "Commit" selections____.onCommit,
 Object.buildFragment "Tag" selections____.onTag,
 Object.buildFragment "Tree" selections____.onTree
        ]


{-| Can be used to create a non-exhaustive set of fragments by using the record
update syntax to add `SelectionSet`s for the types you want to handle.
-}
maybeFragments : Fragments (Maybe decodesTo)
maybeFragments =
    {
      onBlob = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onCommit = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onTag = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing),
 onTree = Graphql.SelectionSet.empty |> Graphql.SelectionSet.map (\_ -> Nothing)
    }
{-| An abbreviated version of the Git object ID
-}
abbreviatedOid : SelectionSet String GithubNoFormat.Interface.GitObject
abbreviatedOid =
      Object.selectionForField "String" "abbreviatedOid" [] (Decode.string)


{-| The HTTP path for this Git object
-}
commitResourcePath : SelectionSet GithubNoFormat.ScalarCodecs.Uri GithubNoFormat.Interface.GitObject
commitResourcePath =
      Object.selectionForField "ScalarCodecs.Uri" "commitResourcePath" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecUri |> .decoder)


{-| The HTTP URL for this Git object
-}
commitUrl : SelectionSet GithubNoFormat.ScalarCodecs.Uri GithubNoFormat.Interface.GitObject
commitUrl =
      Object.selectionForField "ScalarCodecs.Uri" "commitUrl" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecUri |> .decoder)


id : SelectionSet GithubNoFormat.ScalarCodecs.Id GithubNoFormat.Interface.GitObject
id =
      Object.selectionForField "ScalarCodecs.Id" "id" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The Git object ID
-}
oid : SelectionSet GithubNoFormat.ScalarCodecs.GitObjectID GithubNoFormat.Interface.GitObject
oid =
      Object.selectionForField "ScalarCodecs.GitObjectID" "oid" [] (GithubNoFormat.ScalarCodecs.codecs |> GithubNoFormat.Scalar.unwrapCodecs |> .codecGitObjectID |> .decoder)


{-| The Repository the Git object belongs to
-}
repository : SelectionSet decodesTo GithubNoFormat.Object.Repository
 -> SelectionSet decodesTo GithubNoFormat.Interface.GitObject
repository object____ =
      Object.selectionForCompositeField "repository" [] (object____) (Basics.identity)
