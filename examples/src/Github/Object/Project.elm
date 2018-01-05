module Github.Object.Project exposing (..)

import Github.Enum.ProjectState
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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.Project
selection constructor =
    Object.object constructor


{-| The project's description body.
-}
body : FieldDecoder (Maybe String) Github.Object.Project
body =
    Object.fieldDecoder "body" [] (Decode.string |> Decode.maybe)


{-| The projects description body rendered to HTML.
-}
bodyHTML : FieldDecoder String Github.Object.Project
bodyHTML =
    Object.fieldDecoder "bodyHTML" [] Decode.string


{-| `true` if the object is closed (definition of closed may depend on type)
-}
closed : FieldDecoder Bool Github.Object.Project
closed =
    Object.fieldDecoder "closed" [] Decode.bool


{-| Identifies the date and time when the object was closed.
-}
closedAt : FieldDecoder (Maybe String) Github.Object.Project
closedAt =
    Object.fieldDecoder "closedAt" [] (Decode.string |> Decode.maybe)


{-| List of columns in the project

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
columns : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.ProjectColumnConnection -> FieldDecoder selection Github.Object.Project
columns fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "columns" optionalArgs object identity


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.Project
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The actor who originally created the project.
-}
creator : SelectionSet selection Github.Interface.Actor -> FieldDecoder (Maybe selection) Github.Object.Project
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.Project
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.Project
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The project's name.
-}
name : FieldDecoder String Github.Object.Project
name =
    Object.fieldDecoder "name" [] Decode.string


{-| The project's number.
-}
number : FieldDecoder Int Github.Object.Project
number =
    Object.fieldDecoder "number" [] Decode.int


{-| The project's owner. Currently limited to repositories and organizations.
-}
owner : SelectionSet selection Github.Interface.ProjectOwner -> FieldDecoder selection Github.Object.Project
owner object =
    Object.selectionFieldDecoder "owner" [] object identity


{-| List of pending cards in this project

  - first - Returns the first _n_ elements from the list.
  - after - Returns the elements in the list that come after the specified global ID.
  - last - Returns the last _n_ elements from the list.
  - before - Returns the elements in the list that come before the specified global ID.

-}
pendingCards : ({ first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String } -> { first : OptionalArgument Int, after : OptionalArgument String, last : OptionalArgument Int, before : OptionalArgument String }) -> SelectionSet selection Github.Object.ProjectCardConnection -> FieldDecoder selection Github.Object.Project
pendingCards fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { first = Absent, after = Absent, last = Absent, before = Absent }

        optionalArgs =
            [ Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "last" filledInOptionals.last Encode.int, Argument.optional "before" filledInOptionals.before Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionFieldDecoder "pendingCards" optionalArgs object identity


{-| The HTTP path for this project
-}
resourcePath : FieldDecoder String Github.Object.Project
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| Whether the project is open or closed.
-}
state : FieldDecoder Github.Enum.ProjectState.ProjectState Github.Object.Project
state =
    Object.fieldDecoder "state" [] Github.Enum.ProjectState.decoder


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.Project
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL for this project
-}
url : FieldDecoder String Github.Object.Project
url =
    Object.fieldDecoder "url" [] Decode.string


{-| Check if the current viewer can update this object.
-}
viewerCanUpdate : FieldDecoder Bool Github.Object.Project
viewerCanUpdate =
    Object.fieldDecoder "viewerCanUpdate" [] Decode.bool
