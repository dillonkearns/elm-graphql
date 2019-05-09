# subscription-apollo

Example usage of GraphQL subscriptions using Elm-GraphQL and [Apollo Client](https://github.com/apollographql/apollo-client).

### [Demo](https://elm-apollo-subscriptions.now.sh/) 

## Motivation

  In the javascript world, the easiest way to test/integrate GraphQL subscriptions is by using apollo client and since elm-graphql doesn't have a native websockets client ([this](https://github.com/dillonkearns/elm-graphql/issues/70#issue-354938870) and [this](https://github.com/dillonkearns/elm-graphql/issues/43)), this is an example app showing how you can integrate apollo style subscriptions with an elm app using elm-graphql. Uses apollo-client and ports.

## Testing live demo:
1. Go to this [link](https://elm-apollo-subscriptions.now.sh/)
2. On your terminal, run: `npx graphqurl https://elm-apollo-graphql.herokuapp.com/v1alpha1/graphql -q 'mutation insertAuthor { insert_author (objects: [ { name: "J.R.R Tolkien" }]) { affected_rows } }'`
3. See that the UI updates automatically

Notes: The backend is built with [Hasura](https://github.com/hasura/graphql-engine) and deployed on a heroku app at: [https://elm-apollo-graphql.herokuapp.com/console/](https://elm-apollo-graphql.herokuapp.com/console/)
