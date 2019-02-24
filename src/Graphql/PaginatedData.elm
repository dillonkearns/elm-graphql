module Graphql.PaginatedData exposing (CurrentPage, Direction(..), PageInfo, PaginatedData, addPageInfo, init)

import Graphql.OptionalArgument as OptionalArgument exposing (OptionalArgument(..))


init : Direction -> List data -> PaginatedData data
init direction initialData =
    { data = initialData
    , currentPage = { cursor = Nothing, isLoading = True }
    , direction = direction
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
