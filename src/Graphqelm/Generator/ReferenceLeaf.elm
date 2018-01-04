module Graphqelm.Generator.ReferenceLeaf exposing (ReferenceLeaf(..), get)

import Graphqelm.Parser.Type as Type exposing (TypeReference(TypeReference))


type ReferenceLeaf
    = Object
    | Enum
    | Union
    | Interface
    | Scalar



-- type TypeReference
--     = TypeReference ReferrableType IsNullable


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
            Debug.crash "TODO"

        Type.UnionRef _ ->
            Union

        Type.InterfaceRef _ ->
            Interface
