module GraphqElm.TypeLock exposing (..)

import GraphqElm.Field exposing (TypeLocked(TypeLocked))


unlock : TypeLocked a lockedTo -> a
unlock (TypeLocked value) =
    value


unlockAll : List (TypeLocked a lockedTo) -> List a
unlockAll list =
    list |> List.map unlock
