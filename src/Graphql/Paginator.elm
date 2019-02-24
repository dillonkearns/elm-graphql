module Graphql.Paginator exposing (Direction(..), PageInfo, Paginator, addPageInfo, backward, data, forward, moreToLoad, selectionSet)

import Graphql.Internal.Paginator exposing (CurrentPage)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)


moreToLoad : Paginator data -> Bool
moreToLoad (Paginator paginator) =
    paginator.currentPage.isLoading


data : Paginator data -> List data
data (Paginator paginator) =
    paginator.data


forward : Paginator data
forward =
    Paginator
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateForward
        }


backward : Paginator data
backward =
    Paginator
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateBackward
        }


selectionSet :
    Int
    -> Paginator decodesTo
    -> SelectionSet (List decodesTo) typeLock
    -> SelectionSet (Paginator decodesTo) typeLock
selectionSet pageSize (Paginator paginator) selection =
    Graphql.SelectionSet.map3 PaginatorRecord
        (selection |> Graphql.SelectionSet.map (\newList -> paginator.data ++ newList))
        Graphql.Internal.Paginator.forwardSelection
        (Graphql.SelectionSet.succeed paginator.direction)
        |> Graphql.SelectionSet.map Paginator


type Paginator data
    = Paginator (PaginatorRecord data)


type alias PaginatorRecord data =
    { data : List data
    , currentPage : CurrentPage
    , direction : Direction
    }


type alias PageInfo pageInfo =
    { pageInfo
        | first : OptionalArgument Int
        , last : OptionalArgument Int
        , before : OptionalArgument String
        , after : OptionalArgument String
    }


{-| TODO
-}
addPageInfo : Int -> Paginator data -> PageInfo pageInfo -> PageInfo pageInfo
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
