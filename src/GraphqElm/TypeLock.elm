module GraphqElm.TypeLock exposing (..)


type TypeLocked thing lockedTo
    = TypeLocked thing


unlock : TypeLocked a lockedTo -> a
unlock (TypeLocked value) =
    value


unlockAll : List (TypeLocked a lockedTo) -> List a
unlockAll list =
    list |> List.map unlock
