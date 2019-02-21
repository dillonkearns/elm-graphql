module Graphql.PaginatorSetup exposing (CurrentPage, PaginatorSetup(..))

{-| TODO
-}


{-| Uses [the relay protocol](https://facebook.github.io/relay/graphql/connections.htm).
-}
type PaginatorSetup
    = Forward { first : Int }
    | Backward { last : Int }


type alias CurrentPage cursorType =
    { cursor : Maybe cursorType
    , done : Bool
    }
