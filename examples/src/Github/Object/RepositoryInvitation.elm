module Github.Object.RepositoryInvitation exposing (..)

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


selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.RepositoryInvitation
selection constructor =
    Object.object constructor


id : FieldDecoder String Github.Object.RepositoryInvitation
id =
    Object.fieldDecoder "id" [] Decode.string


{-| The user who received the invitation.
-}
invitee : SelectionSet selection Github.Object.User -> FieldDecoder selection Github.Object.RepositoryInvitation
invitee object =
    Object.selectionFieldDecoder "invitee" [] object identity


{-| The user who created the invitation.
-}
inviter : SelectionSet selection Github.Object.User -> FieldDecoder selection Github.Object.RepositoryInvitation
inviter object =
    Object.selectionFieldDecoder "inviter" [] object identity


{-| The Repository the user is invited to.
-}
repository : SelectionSet selection Github.Object.RepositoryInvitationRepository -> FieldDecoder (Maybe selection) Github.Object.RepositoryInvitation
repository object =
    Object.selectionFieldDecoder "repository" [] object (identity >> Decode.maybe)
