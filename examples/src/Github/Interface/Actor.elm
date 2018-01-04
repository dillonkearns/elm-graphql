module Github.Interface.Actor exposing (..)

import Github.Interface
import Github.Object
import Github.Union
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (FragmentSelectionSet(FragmentSelectionSet), SelectionSet(SelectionSet))
import Json.Decode as Decode


baseSelection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Interface.Actor
baseSelection constructor =
    Object.object constructor


selection : (Maybe typeSpecific -> a -> constructor) -> List (FragmentSelectionSet typeSpecific Github.Interface.Actor) -> SelectionSet (a -> constructor) Github.Interface.Actor
selection constructor typeSpecificDecoders =
    Object.polymorphicObject typeSpecificDecoders constructor


onBot : SelectionSet selection Github.Object.Bot -> FragmentSelectionSet selection Github.Interface.Actor
onBot (SelectionSet fields decoder) =
    FragmentSelectionSet "Bot" fields decoder


onOrganization : SelectionSet selection Github.Object.Organization -> FragmentSelectionSet selection Github.Interface.Actor
onOrganization (SelectionSet fields decoder) =
    FragmentSelectionSet "Organization" fields decoder


onUser : SelectionSet selection Github.Object.User -> FragmentSelectionSet selection Github.Interface.Actor
onUser (SelectionSet fields decoder) =
    FragmentSelectionSet "User" fields decoder


{-| A URL pointing to the actor's public avatar.

  - size - The size of the resulting square image.

-}
avatarUrl : ({ size : OptionalArgument Int } -> { size : OptionalArgument Int }) -> FieldDecoder String Github.Interface.Actor
avatarUrl fillInOptionals =
    let
        filledInOptionals =
            fillInOptionals { size = Absent }

        optionalArgs =
            [ Argument.optional "size" filledInOptionals.size Encode.int ]
                |> List.filterMap identity
    in
    Object.fieldDecoder "avatarUrl" optionalArgs Decode.string


{-| The username of the actor.
-}
login : FieldDecoder String Github.Interface.Actor
login =
    Object.fieldDecoder "login" [] Decode.string


{-| The HTTP path for this actor.
-}
resourcePath : FieldDecoder String Github.Interface.Actor
resourcePath =
    Object.fieldDecoder "resourcePath" [] Decode.string


{-| The HTTP URL for this actor.
-}
url : FieldDecoder String Github.Interface.Actor
url =
    Object.fieldDecoder "url" [] Decode.string
