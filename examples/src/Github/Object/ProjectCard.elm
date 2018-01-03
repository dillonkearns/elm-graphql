module Github.Object.ProjectCard exposing (..)

import Github.Enum.ProjectCardState
import Github.Interface
import Github.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ProjectCard
selection constructor =
    Object.object constructor


{-| The project column this card is associated under. A card may only belong to one
project column at a time. The column field will be null if the card is created
in a pending state and has yet to be associated with a column. Once cards are
associated with a column, they will not become pending in the future.
-}
column : SelectionSet column Github.Object.ProjectColumn -> FieldDecoder (Maybe column) Github.Object.ProjectCard
column object =
    Object.selectionFieldDecoder "column" [] object (identity >> Decode.maybe)


{-| The card content item
-}
content : FieldDecoder (Maybe String) Github.Object.ProjectCard
content =
    Object.fieldDecoder "content" [] (Decode.string |> Decode.maybe)


{-| Identifies the date and time when the object was created.
-}
createdAt : FieldDecoder String Github.Object.ProjectCard
createdAt =
    Object.fieldDecoder "createdAt" [] Decode.string


{-| The actor who created this card
-}
creator : SelectionSet creator Github.Interface.Actor -> FieldDecoder (Maybe creator) Github.Object.ProjectCard
creator object =
    Object.selectionFieldDecoder "creator" [] object (identity >> Decode.maybe)


{-| Identifies the primary key from the database.
-}
databaseId : FieldDecoder (Maybe Int) Github.Object.ProjectCard
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.maybe)


id : FieldDecoder String Github.Object.ProjectCard
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The card note
-}
note : FieldDecoder (Maybe String) Github.Object.ProjectCard
note =
    Object.fieldDecoder "note" [] (Decode.string |> Decode.maybe)


{-| The project that contains this card.
-}
project : SelectionSet project Github.Object.Project -> FieldDecoder project Github.Object.ProjectCard
project object =
    Object.selectionFieldDecoder "project" [] object identity


{-| The column that contains this card.
-}
projectColumn : SelectionSet projectColumn Github.Object.ProjectColumn -> FieldDecoder projectColumn Github.Object.ProjectCard
projectColumn object =
    Object.selectionFieldDecoder "projectColumn" [] object identity


{-| The HTTP path for this card
-}
resourcePath : FieldDecoder String Github.Object.ProjectCard
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The state of ProjectCard
-}
state : FieldDecoder (Maybe Github.Enum.ProjectCardState.ProjectCardState) Github.Object.ProjectCard
state =
    Object.fieldDecoder "state" [] (Github.Enum.ProjectCardState.decoder |> Decode.maybe)


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : FieldDecoder String Github.Object.ProjectCard
updatedAt =
    Object.fieldDecoder "updatedAt" [] Decode.string


{-| The HTTP URL for this card
-}
url : FieldDecoder String Github.Object.ProjectCard
url =
    Object.fieldDecoder "url" [] Decode.string
