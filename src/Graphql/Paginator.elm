module Graphql.Paginator exposing (Backward, Forward, PageInfo, Paginator, addPageInfo, backward, forward, moreToLoad, nodes, selectionSet)

import Graphql.Internal.Paginator exposing (CurrentPage)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)


type Paginator direction data
    = Paginator (PaginatorRecord data)


type alias PaginatorRecord data =
    { nodes : List data
    , currentPage : CurrentPage
    , direction : Direction
    }


forward : Paginator Forward node
forward =
    Paginator
        { nodes = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = Forward
        }


backward : Paginator Backward node
backward =
    Paginator
        { nodes = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = Backward
        }


moreToLoad : Paginator direction data -> Bool
moreToLoad (Paginator paginator) =
    paginator.currentPage.isLoading


nodes : Paginator direction node -> List node
nodes (Paginator paginator) =
    paginator.nodes
        |> List.reverse


selectionSet :
    Int
    -> Paginator direction decodesTo
    -> SelectionSet (List decodesTo) typeLock
    -> SelectionSet (Paginator direction decodesTo) typeLock
selectionSet pageSize (Paginator paginator) selection =
    Graphql.SelectionSet.map3 PaginatorRecord
        (selection
            |> Graphql.SelectionSet.map
                (\newNodes ->
                    newNodes ++ paginator.nodes
                )
        )
        (case paginator.direction of
            Forward ->
                Graphql.Internal.Paginator.forwardSelection

            Backward ->
                Graphql.Internal.Paginator.backwardSelection
        )
        (Graphql.SelectionSet.succeed paginator.direction)
        |> Graphql.SelectionSet.map Paginator


type alias PageInfo pageInfo =
    { pageInfo
        | first : OptionalArgument Int
        , last : OptionalArgument Int
        , before : OptionalArgument String
        , after : OptionalArgument String
    }


{-| TODO
-}
addPageInfo : Int -> Paginator direction data -> PageInfo pageInfo -> PageInfo pageInfo
addPageInfo pageSize (Paginator paginator) optionals =
    case paginator.direction of
        Forward ->
            { optionals
                | first = Present pageSize
                , after = OptionalArgument.fromMaybe paginator.currentPage.cursor
            }

        Backward ->
            { optionals
                | last = Present pageSize
                , before = OptionalArgument.fromMaybe paginator.currentPage.cursor
            }


type Forward
    = ForwardValue


type Backward
    = BackwardValue


{-| Uses [the relay protocol](https://facebook.github.io/relay/graphql/connections.htm).
-}
type Direction
    = Forward
    | Backward
