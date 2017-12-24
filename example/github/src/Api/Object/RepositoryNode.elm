module Api.Object.RepositoryNode exposing (..)

import Api.Object
import Graphqelm.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Builder.Object as Object
import Graphqelm.Encode as Encode exposing (Value)
import Graphqelm.FieldDecoder as FieldDecoder exposing (FieldDecoder)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.RepositoryNode
selection constructor =
    Object.object constructor


repository : SelectionSet repository Api.Object.Repository -> FieldDecoder repository Api.Object.RepositoryNode
repository object =
    Object.single "repository" [] object
