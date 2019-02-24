module Graphql.Paginator exposing (Backward, Direction(..), Forward, PageInfo, Paginator, addPageInfo, backward, data, forward, moreToLoad, selectionSet)

import Graphql.Internal.Paginator exposing (CurrentPage)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)


type Paginator direction data
    = Paginator (PaginatorRecord data)


type alias PaginatorRecord data =
    { data : List data
    , currentPage : CurrentPage
    , direction : Direction
    }


forward : Paginator Forward data
forward =
    Paginator
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateForward
        }


backward : Paginator Backward data
backward =
    Paginator
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateBackward
        }


moreToLoad : Paginator direction data -> Bool
moreToLoad (Paginator paginator) =
    paginator.currentPage.isLoading


data : Paginator direction data -> List data
data (Paginator paginator) =
    paginator.data


selectionSet :
    Int
    -> Paginator direction decodesTo
    -> SelectionSet (List decodesTo) typeLock
    -> SelectionSet (Paginator direction decodesTo) typeLock
selectionSet pageSize (Paginator paginator) selection =
    Graphql.SelectionSet.map3 PaginatorRecord
        (selection |> Graphql.SelectionSet.map (\newList -> paginator.data ++ newList))
        (case paginator.direction of
            PaginateForward ->
                Graphql.Internal.Paginator.forwardSelection

            PaginateBackward ->
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
        PaginateForward ->
            { optionals
                | first = Present pageSize
                , after = OptionalArgument.fromMaybe paginator.currentPage.cursor
            }

        PaginateBackward ->
            { optionals
                | last = Present pageSize
                , before = OptionalArgument.fromMaybe paginator.currentPage.cursor
            }


type Forward
    = Forward


type Backward
    = Backward


{-| Uses [the relay protocol](https://facebook.github.io/relay/graphql/connections.htm).
-}
type Direction
    = PaginateForward
    | PaginateBackward
