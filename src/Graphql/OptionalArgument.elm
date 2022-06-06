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
      import Graphql.OptionalArgument exposing (OptionalArgument(..))
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
[The official GraphQL spec section on null](https://spec.graphql.org/October2016/#sec-Null-Value)
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


{-| Convert a `Maybe` to an OptionalArgument, converting `Nothing` into
`Null` (rather than `Absent`). See `OptionalArgument.fromMaybe` for an alternative
which turns `Nothing` into `Absent`.

This can be handy if you are performing a mutation
where you want to "null out" some data in your API. Sending an `Absent` value
(i.e. omitting the optional argument) in the mutation arguments won't update
the value, but the server logic defines sending `null` as deleting the value.
Of course, this all depends on the custom logic you define in the resolvers in
your server's implementation of your API.

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
