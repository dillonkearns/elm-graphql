module Graphql.Pagination exposing (CurrentPage, Direction(..), PageInfo, PaginatedData, addPageInfo, init)

import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))


init : Direction -> List data -> PaginatedData data cursor
init direction initialData =
    { data = initialData
    , currentPage = { cursor = Nothing, hasNextPage = True }
    , direction = direction
    }


type alias PaginatedData data cursor =
    { data : List data
    , currentPage : CurrentPage cursor
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
        Forward ->
            { optionals
                | first = Present pageSize
                , after = OptionalArgument.fromMaybe maybeCursor
            }

        Backward ->
            { optionals
                | last = Present pageSize
                , before = OptionalArgument.fromMaybe maybeCursor
            }


{-| Uses [the relay protocol](https://facebook.github.io/relay/graphql/connections.htm).
-}
type Direction
    = Forward
    | Backward


type alias CurrentPage cursorType =
    { cursor : Maybe cursorType
    , hasNextPage : Bool
    }
