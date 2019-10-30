module Graphql.QueryParser exposing 
    ( FieldType
    , Name
    , NonNullType(..)
    , OperationDefintion(..)
    , OperationRecord
    , OperationType(..)
    , Selection(..)
    , SelectionSet
    , Type(..)
    , VariableDefinition
    , Value(..)
    , parse
    , Argument
    )

import Debug
import Dict exposing (Dict)
import Graphql.Generator.Context exposing (Context)
import Graphql.Generator.Decoder as Decoder
import Graphql.Generator.Group exposing (IntrospectionData)
import Graphql.Generator.ModuleName as ModuleName
import Graphql.Parser.CamelCaseName as CamelCaseName
import Graphql.Parser.ClassCaseName as ClassCaseName
import Graphql.Parser.Type exposing (..)
import Parser
    exposing
        ( (|.)
        , (|=)
        , Parser
        , Step
        , Trailing(..)
        , float
        , loop
        , map
        , oneOf
        , spaces
        , succeed
        , symbol
        )
import Set exposing (Set)

-- https://github.com/graphql/graphql-spec/blob/master/spec/Section%202%20--%20Language.md

-- Name :: /[_A-Za-z][_0-9A-Za-z]*/


type alias Name =
    String


type OperationDefintion
    = SelectionSet SelectionSet
    | Operation OperationRecord


type alias OperationRecord =
    { type_ : OperationType
    , name : Maybe Name
    , variableDefinitions : List VariableDefinition
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
    = NamedType Name
    | ListType Type
    | NonNullType NonNullType


type NonNullType
    = NonNullNamedType Name
    | NonNullListType Type


type alias SelectionSet =
    List Selection


type Selection
    = Field FieldType



-- | FragmentSpread FragmentSpreadType TBD
-- | InlineFragment InlineFragmentType TBD


type alias FieldType =
    { alias : Maybe Name
    , name : Name
    , arguments: List Argument
    -- , directives: List Directive TBD
    , selectionSet : Maybe SelectionSet
    }


type Value 
    = Variable Name
    | IntValue Int
    | FloatValue Float
    | StringValue String
    | BooleanValue Bool
    | NullValue 
    | EnumValue Name
    | ListValue (List Value)
    | ObjectValue (List (Name, Value))

type alias Argument =
    { name : Name
    , value : Value
    }

parse query =
    Parser.run parser query


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
        |= oneOf
            [ variableDefinitions
            , succeed []
            ]
        |. spaces
        |= selectionSet
        |. spaces

variableDefinitions : Parser (List VariableDefinition)
variableDefinitions =
    Parser.sequence
        { start = "("
        , separator = ","
        , end = ")"
        , spaces = spaces
        , item = variableDefinition
        , trailing = Forbidden
        }

variableDefinition : Parser VariableDefinition
variableDefinition = 
    Parser.succeed VariableDefinition
        |. spaces
        |. symbol "$"
        |= name
        |. spaces
        |. symbol ":"
        |. spaces
        |= type_
        |. spaces

type_ : Parser Type
type_ =
    oneOf
        [ Parser.backtrackable (Parser.map ListType (listType (\_ -> type_)))
        , Parser.backtrackable (Parser.map NonNullType (nonNullType (\_ -> type_)))
        , Parser.backtrackable (Parser.map NamedType name)
        ]

listType : (() -> Parser Type) -> Parser Type
listType typeParser =
    succeed identity
        |. symbol "["
        |. spaces
        |= Parser.lazy typeParser
        |. spaces
        |. symbol "]"


nonNullType : (() -> Parser Type) -> Parser NonNullType
nonNullType typeParser =
    succeed identity
        |= oneOf 
            [ Parser.map NonNullNamedType name
            , Parser.map NonNullListType (listType typeParser) 
            ]
        |. symbol "!"

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


field : Parser Selection
field =
    Parser.succeed FieldType
        |= succeed Nothing --alias TBD
        |. spaces
        |= name
        |. spaces
        |= optionalArguments
        |. spaces
        |= oneOf
            [ Parser.backtrackable (Parser.map Just selectionSet)
            , succeed Nothing
            ]
        |> Parser.map Field

optionalArguments : Parser (List Argument)
optionalArguments =
    oneOf
        [ arguments
        , succeed []
        ]

arguments : Parser (List Argument)
arguments =
    Parser.sequence
        { start = "("
        , separator = ","
        , end = ")"
        , spaces = spaces
        , item = argument
        , trailing = Forbidden
        }

argument : Parser Argument
argument =
    succeed Argument
        |= name
        |. spaces
        |. symbol ":"
        |. spaces
        |= value


kvp : Parser ( Name, Value )
kvp =
    kvp_ (always value)

kvp_ : (() -> Parser Value) -> Parser ( Name, Value )
kvp_ valueParser =
    succeed (\a b -> (a,b))
        |= name
        |. spaces
        |. symbol ":"
        |. spaces
        |= Parser.lazy valueParser

alias : Parser (Maybe Name)
alias =
    oneOf
        [ Parser.map Just name
        , succeed Nothing
        ]

value : Parser Value
value =
    oneOf
        [ variable
        , Parser.map IntValue Parser.int
        , Parser.map FloatValue Parser.float
        , Parser.map StringValue (Parser.getChompedString <| Parser.succeed ()
            |. symbol "\""
            |. Parser.chompWhile (\c -> c /= '\u{000D}' && c /= '\n' && c /= '"')
            |. symbol "\"")
        , Parser.oneOf
            [ Parser.map (always (BooleanValue True)) (symbol "true")
            , Parser.map (always (BooleanValue False)) (symbol "false")
            ]
        , Parser.map (always NullValue) (symbol "null")
        , Parser.map EnumValue name
        , listValue (\() -> value)
        , objectValue (\() -> value)
        ]

variable : Parser Value
variable =
    succeed Variable
        |. symbol "$"
        |= name

listValue : (() -> Parser Value) -> Parser Value
listValue valueParser =
    Parser.map ListValue <|
        Parser.sequence
            { start = "["
            , separator = ""
            , end = "]"
            , spaces = spaces
            , item = Parser.lazy valueParser
            , trailing = Optional
            }

objectValue : (() -> Parser Value) -> Parser Value
objectValue valueParser =
    Parser.map ObjectValue <|
        Parser.sequence
            { start = "{"
            , separator = ""
            , end = "}"
            , spaces = spaces
            , item = kvp_ valueParser
            , trailing = Optional
            }

selectionSet : Parser (List Selection)
selectionSet =
    succeed identity
        |. spaces
        |. symbol "{"
        |. spaces
        |= loop [] fieldsHelper
        |. spaces
        |. symbol "}"
        |. spaces


fieldsHelper : List Selection -> Parser (Step (List Selection) (List Selection))
fieldsHelper revStmts =
    oneOf
        [ succeed (\stmt -> Parser.Loop (stmt :: revStmts))
            |. spaces
            |= field
            |. spaces
        , succeed ()
            |> map (\_ -> Parser.Done (List.reverse revStmts))
        ]

