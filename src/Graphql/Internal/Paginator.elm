module Graphql.Internal.Paginator exposing (fromSetup)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.PaginatorSetup exposing (CurrentPage, Direction(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


fromSetup : Direction -> SelectionSet (CurrentPage String) pageInfo
fromSetup paginatorSetup =
    Graphql.SelectionSet.map2 CurrentPage
        endCursor
        hasNextPage


{-| When paginating forwards, the cursor to continue.
-}
endCursor : SelectionSet (Maybe String) pageInfo
endCursor =
    Object.selectionForField "(Maybe String)" "endCursor" [] (Decode.string |> Decode.nullable)


{-| When paginating forwards, are there more items?
-}
hasNextPage : SelectionSet Bool pageInfo
hasNextPage =
    Object.selectionForField "Bool" "hasNextPage" [] Decode.bool


{-| When paginating backwards, are there more items?
-}
hasPreviousPage : SelectionSet Bool pageInfo
hasPreviousPage =
    Object.selectionForField "Bool" "hasPreviousPage" [] Decode.bool


{-| When paginating backwards, the cursor to continue.
-}
startCursor : SelectionSet (Maybe String) pageInfo
startCursor =
    Object.selectionForField "(Maybe String)" "startCursor" [] (Decode.string |> Decode.nullable)
