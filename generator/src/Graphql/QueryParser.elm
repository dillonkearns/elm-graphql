module Graphql.QueryParser exposing (FieldType, ListType, Name, NamedType(..), NonNullType(..), OperationDefintion(..), OperationRecord, OperationType(..), Selection(..), SelectionSet, Type(..), VariableDefinition, alias, field, fieldsHelper, name, operation, operationType, parser, selectionSet)

import Parser
    exposing
        ( (|.)
        , (|=)
        , Parser
        , Step
        , Trailing
        , float
        , loop
        , map
        , oneOf
        , spaces
        , succeed
        , symbol
        )
import Set



-- Name :: /[_A-Za-z][_0-9A-Za-z]*/


type alias Name =
    String


type OperationDefintion
    = SelectionSet SelectionSet
    | Operation OperationRecord


type alias OperationRecord =
    { type_ : OperationType
    , name : Maybe Name

    -- , variableDefinitions : List VariableDefinition TBD
    -- , directives: List Directive TBD
    , selectionSet : SelectionSet
    }


type OperationType
    = Query
    | Mutation
    | Subscription



-- VariableDefinition : Variable : Type DefaultValue? Directives[Const]?


type alias VariableDefinition =
    { variable : Name
    , type_ : Type

    -- , defaultValue: Maybe DefaultValue TBD
    -- , directives: List Directive TBD
    }


type Type
    = NamedType NamedType
    | ListType ListType
    | NonNullType NonNullType


type NamedType
    = Name


type alias ListType =
    List Type


type NonNullType
    = NonNullNamedType NamedType
    | NonNullListType ListType


type alias SelectionSet =
    List Selection


type Selection
    = Field FieldType



-- | FragmentSpread FragmentSpreadType TBD
-- | InlineFragment InlineFragmentType TBD


type alias FieldType =
    { alias : Maybe Name
    , name : Name

    -- , arguments: List Argument TBD
    -- , directives: List Directive TBD
    , selectionSet : Maybe SelectionSet
    }


parser : Parser OperationDefintion
parser =
    oneOf
        [ Parser.map Operation operation
        , Parser.map SelectionSet selectionSet
        ]


operation : Parser OperationRecord
operation =
    Parser.succeed OperationRecord
        |. spaces
        |= operationType
        |. spaces
        |= alias
        |. spaces
        |= selectionSet
        |. spaces


operationType : Parser OperationType
operationType =
    oneOf
        [ map (always Query) (symbol "query")
        , map (always Mutation) (symbol "mutation")
        , map (always Subscription) (symbol "subscription")
        ]


name : Parser Name
name =
    Parser.variable
        { start = Char.isAlpha
        , inner = \c -> Char.isAlphaNum c || c == '_'
        , reserved = Set.fromList [ "query", "mutation", "subscription" ]
        }



-- selectionSet : Parser SelectionSet
-- selectionSet =
--   Parser.sequence
--     { start = "{"
--     , separator = "\n"
--     , end = "}"
--     , spaces = spaces
--     , item = field
--     , trailing = Parser.Optional
--     }


field : Parser Selection
field =
    Parser.succeed FieldType
        |= succeed Nothing --alias TBD
        |= name
        |= oneOf
            [ Parser.map Just selectionSet
            , succeed Nothing
            ]
        |> Parser.map Field


alias : Parser (Maybe Name)
alias =
    oneOf
        [ Parser.map Just name
        , succeed Nothing
        ]



-- selectionSet : Parser SelectionSet


selectionSet : Parser (List Selection)
selectionSet =
  succeed identity
    |. symbol "{"
    |. spaces
    |= loop [] fieldsHelper
    |. spaces
    |. symbol "}"


fieldsHelper : List Selection -> Parser (Step (List Selection) (List Selection))
fieldsHelper revStmts =
    oneOf
        [ succeed (\stmt -> Parser.Loop (stmt :: revStmts))
            |. spaces
            |= field
            |. spaces
            -- |. symbol "\n"
            -- |. spaces
        , succeed ()
            |> map (\_ -> Parser.Done (List.reverse revStmts))
        ]
