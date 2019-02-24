module Graphql.PaginatedData exposing (CurrentPage, Direction(..), PageInfo, PaginatedData, addPageInfo, backward, forward)

import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))


forward : PaginatedData data
forward =
    { data = []
    , currentPage = { cursor = Nothing, isLoading = True }
    , direction = PaginateForward
    }


backward : PaginatedData data
backward =
    { data = []
    , currentPage = { cursor = Nothing, isLoading = True }
    , direction = PaginateBackward
    }


type alias PaginatedData data =
    { data : List data
    , currentPage : CurrentPage
    , direction : Direction
    }


type alias PageInfo pageInfo cursor =
    { pageInfo
        | first : OptionalArgument Int
        , last : OptionalArgument Int
        , before : OptionalArgument cursor
        , after : OptionalArgument cursor
    }


{-| TODO
-}
addPageInfo : Int -> Maybe cursor -> Direction -> PageInfo pageInfo cursor -> PageInfo pageInfo cursor
addPageInfo pageSize maybeCursor paginationSetup optionals =
    case paginationSetup of
        PaginateForward ->
            { optionals
                | first = Present pageSize
                , after = OptionalArgument.fromMaybe maybeCursor
            }

        PaginateBackward ->
            { optionals
                | last = Present pageSize
                , before = OptionalArgument.fromMaybe maybeCursor
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


type alias CurrentPage =
    { cursor : Maybe String
    , isLoading : Bool
    }
