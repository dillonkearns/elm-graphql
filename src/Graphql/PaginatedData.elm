module Graphql.PaginatedData exposing (Direction(..), PageInfo, PaginatedData, addPageInfo, backward, data, forward, moreToLoad, selectionSet)

import Graphql.Internal.Paginator exposing (CurrentPage)
import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)


moreToLoad : PaginatedData data -> Bool
moreToLoad (PaginatedData paginator) =
    paginator.currentPage.isLoading


data : PaginatedData data -> List data
data (PaginatedData paginator) =
    paginator.data


forward : PaginatedData data
forward =
    PaginatedData
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateForward
        }


backward : PaginatedData data
backward =
    PaginatedData
        { data = []
        , currentPage = { cursor = Nothing, isLoading = True }
        , direction = PaginateBackward
        }


selectionSet :
    Int
    -> PaginatedData decodesTo
    -> SelectionSet (List decodesTo) typeLock
    -> SelectionSet (PaginatedData decodesTo) typeLock
selectionSet pageSize (PaginatedData paginator) selection =
    Graphql.SelectionSet.map3 PaginatedDataRecord
        (selection |> Graphql.SelectionSet.map (\newList -> paginator.data ++ newList))
        Graphql.Internal.Paginator.forwardSelection
        (Graphql.SelectionSet.succeed paginator.direction)
        |> Graphql.SelectionSet.map PaginatedData


type PaginatedData data
    = PaginatedData (PaginatedDataRecord data)


type alias PaginatedDataRecord data =
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
addPageInfo : Int -> PaginatedData data -> PageInfo pageInfo -> PageInfo pageInfo
addPageInfo pageSize (PaginatedData paginator) optionals =
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
