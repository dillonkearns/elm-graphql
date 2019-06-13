module Graphql.OptionalArgument exposing
    ( OptionalArgument(..)
    , fromMaybe
    , fromMaybeWithNull
    , map
    )

{-|

@docs OptionalArgument
@docs fromMaybe
@docs fromMaybeWithNull
@docs map

-}


{-| This type is used to create values to pass in optional arguments.

      import Api.Enum.Episode as Episode exposing (Episode)
      import Api.Query as Query
      import Graphql.Operation exposing (RootQuery)
      import Graphql.OptionalArgument exposing (OptionalArgument(Null, Present))
      import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)


      query : SelectionSet Response RootQuery
      query =
          SelectionSet.succeed Response
              |> with (Query.human { id = "1004" } human)
              |> with (Query.human { id = "1001" } human)
              |> with
                  (Query.hero
                      (\optionals ->
                          { optionals
                              | episode = Present Episode.EMPIRE
                          }
                      )
                      hero
                  )

An optional argument can be either present, absent, or null, so using a Maybe does not
fully capture the GraphQL concept of an optional argument. For example, you could have
a mutation that deletes an entry if a null argument is provided, or does nothing if
the argument is absent. See
[The official GraphQL spec section on null](http://facebook.github.io/graphql/October2016/#sec-Null-Value)
for details.

-}
type OptionalArgument a
    = Present a
    | Absent
    | Null


{-| Convert a `Maybe` to an OptionalArgument.

    fromMaybe (Just a) == Present a
    fromMaybe Nothing == Absent
-}
fromMaybe : Maybe a -> OptionalArgument a
fromMaybe maybeValue =
    case maybeValue of
        Just value ->
            Present value

        Nothing ->
            Absent


{-| Convert a `Maybe` to an OptionalArgument.

    fromMaybeWithNull (Just a) == Present a
    fromMaybeWithNull Nothing == Null
-}
fromMaybeWithNull : Maybe a -> OptionalArgument a
fromMaybeWithNull maybeValue =
    case maybeValue of
        Just value ->
            Present value

        Nothing ->
            Null


{-| Transform an OptionalArgument value with a given function.
-}
map : (a -> b) -> OptionalArgument a -> OptionalArgument b
map transform option =
    case option of
        Present a ->
            Present (transform a)

        Absent ->
            Absent

        Null ->
            Null
