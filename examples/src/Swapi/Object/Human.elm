-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Swapi.Object.Human exposing (..)

import CustomScalarCodecs
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import Swapi.Enum.Episode
import Swapi.InputObject
import Swapi.Interface
import Swapi.Object
import Swapi.Scalar
import Swapi.Union


{-| The ID of the human.
-}
id : SelectionSet CustomScalarCodecs.Id Swapi.Object.Human
id =
    Object.selectionForField "CustomScalarCodecs.Id" "id" [] (CustomScalarCodecs.codecs |> Swapi.Scalar.unwrapCodecs |> .codecId |> .decoder)


{-| The name of the human.
-}
name : SelectionSet String Swapi.Object.Human
name =
    Object.selectionForField "String" "name" [] Decode.string


{-| Which movies they appear in.
-}
appearsIn : SelectionSet (List Swapi.Enum.Episode.Episode) Swapi.Object.Human
appearsIn =
    Object.selectionForField "(List Enum.Episode.Episode)" "appearsIn" [] (Swapi.Enum.Episode.decoder |> Decode.list)


{-| The friends of the human, or an empty list if they have none.
-}
friends :
    SelectionSet decodesTo Swapi.Interface.Character
    -> SelectionSet (List decodesTo) Swapi.Object.Human
friends object____ =
    Object.selectionForCompositeField "friends" [] object____ (Basics.identity >> Decode.list)


{-| Url to a profile picture for the character.
-}
avatarUrl : SelectionSet String Swapi.Object.Human
avatarUrl =
    Object.selectionForField "String" "avatarUrl" [] Decode.string


{-| The home planet of the human, or null if unknown.
-}
homePlanet : SelectionSet (Maybe String) Swapi.Object.Human
homePlanet =
    Object.selectionForField "(Maybe String)" "homePlanet" [] (Decode.string |> Decode.nullable)
