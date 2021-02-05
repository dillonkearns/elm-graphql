module Graphql.Generator.ReferenceLeaf exposing (ReferenceLeaf(..), get)

import Graphql.Parser.Type as Type exposing (TypeReference(..))
import MyDebug


type ReferenceLeaf
    = Object
    | Enum
    | Union
    | Interface
    | Scalar


get : TypeReference -> ReferenceLeaf
get (TypeReference referrableType isNullable) =
    case referrableType of
        Type.ObjectRef _ ->
            Object

        Type.Scalar _ ->
            Scalar

        Type.List nestedType ->
            get nestedType

        Type.EnumRef _ ->
            Enum

        Type.InputObjectRef _ ->
            MyDebug.crash "TODO"

        Type.UnionRef _ ->
            Union

        Type.InterfaceRef _ ->
            Interface
