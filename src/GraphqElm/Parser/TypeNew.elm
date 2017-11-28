module GraphqElm.Parser.TypeNew exposing (..)

import GraphqElm.Parser.Scalar as Scalar exposing (Scalar)
import GraphqElm.Parser.TypeKind as TypeKind exposing (TypeKind)


type alias Field =
    { name : String
    , typeRef : TypeReference
    }


type TypeDefinition
    = TypeDefinition String DefinableType IsNullable


type DefinableType
    = ScalarType Scalar
    | ObjectType (List Field)


type TypeReference
    = TypeReference ReferrableType IsNullable


type ReferrableType
    = Scalar Scalar.Scalar
    | List TypeReference


parse : RawTypeDef -> TypeDefinition
parse (RawTypeDef rawType) =
    case rawType.kind of
        TypeKind.Scalar ->
            TypeDefinition
                "Date"
                (ScalarType (Scalar.Custom { name = "Date" }))
                NonNullable

        TypeKind.Object ->
            TypeDefinition
                rawType.name
                (ObjectType
                    (List.map
                        (\{ name, ofType } ->
                            { name = name
                            , typeRef = parseRef ofType
                            }
                        )
                        (rawType.fields |> Maybe.withDefault [])
                    )
                )
                NonNullable

        TypeKind.List ->
            Debug.crash "TODO"

        TypeKind.NonNull ->
            Debug.crash "TODO"


parseRef : RawTypeRef -> TypeReference
parseRef rawTypeRef =
    TypeReference (Scalar Scalar.String) NonNullable


createType : TypeKind -> Maybe String -> Maybe RawType -> RawType
createType kind name ofType =
    RawType
        { kind = kind
        , name = name
        , ofType = ofType
        }


type IsNullable
    = Nullable
    | NonNullable


type RawType
    = RawType
        { kind : TypeKind
        , name : Maybe String
        , ofType : Maybe RawType
        }


type RawTypeRef
    = RawTypeRef
        { name : Maybe String
        , kind : TypeKind
        , ofType : Maybe RawTypeRef
        }


type RawTypeDef
    = RawTypeDef
        { name : String
        , kind : TypeKind
        , ofType : Maybe RawTypeRef
        , fields : Maybe (List RawField)
        }


type alias RawField =
    { name : String, ofType : RawTypeRef }
