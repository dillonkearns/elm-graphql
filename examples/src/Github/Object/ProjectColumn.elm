module Github.Object.ProjectColumn exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProjectColumn
selection constructor =
    Object.selection constructor


{-| List of cards in the column

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
cards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.ProjectCardConnection -> FieldDecoder selection Github.Object.ProjectColumn
cards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "cards" optionalArgs object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.ProjectColumn
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.ProjectColumn
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.ProjectColumn
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The project column's name.
-}
name : FieldDecoder String Github.Object.ProjectColumn
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The project that contains this column.
-}
project : SelectionSet selection Github.Object.Project -> FieldDecoder selection Github.Object.ProjectColumn
project object =
    Object.selectionFieldDecoder "project" [] object identity


{-| The HTTP path for this project column
-}
resourcePath : FieldDecoder String Github.Object.ProjectColumn
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.ProjectColumn
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL for this project column
-}
url : FieldDecoder String Github.Object.ProjectColumn
url =
    Object.fieldDecoder "url" [] Decode.string
