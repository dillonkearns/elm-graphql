module Github.Object.Gist exposing (..)

import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Gist
selection constructor =
    Object.object constructor


{-| A list of comments associated with the gist

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
comments : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet comments Github.Object.GistCommentConnection -> FieldDecoder comments Github.Object.Gist
comments fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "comments" optionalArgs object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.Gist
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The gist description.
-}
description : FieldDecoder (Maybe String) Github.Object.Gist
description =
    Object.fieldDecoder "description" [] (Decode.string |> Decode.maybe)


id : FieldDecoder String Github.Object.Gist
id =
    Object.fieldDecoder "id" [] Decode.string


{-| Whether the gist is public or not.
-}
isPublic : FieldDecoder Bool Github.Object.Gist
isPublic =
    Object.fieldDecoder "isPublic" [] Decode.bool


{-| The gist name.
-}
name : FieldDecoder String Github.Object.Gist
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The gist owner.
-}
owner : SelectionSet owner Github.Object.RepositoryOwner -> FieldDecoder (Maybe owner) Github.Object.Gist
owner object =
    Object.selectionFieldDecoder "owner" [] object (identity >> Decode.maybe)


{-| Identifies when the gist was last pushed to.
-}
pushedAt : FieldDecoder (Maybe String) Github.Object.Gist
pushedAt =
    Object.fieldDecoder "pushedAt" [] (Decode.string |> Decode.maybe)


{-| A list of users who have starred this starrable.

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.
  - orderBy - Order for connection

-}
stargazers : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String, orderBy : OptionalArgument Value }) -> SelectionSet stargazers Github.Object.StargazerConnection -> FieldDecoder stargazers Github.Object.Gist
stargazers fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent, orderBy = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "orderBy" filledInOptionals.orderBy identity ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "stargazers" optionalArgs object identity


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.Gist
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| Returns a boolean indicating whether the viewing user has starred this starrable.
-}
viewerHasStarred : FieldDecoder Bool Github.Object.Gist
viewerHasStarred =
    Object.fieldDecoder "viewerHasStarred" [] Decode.bool
