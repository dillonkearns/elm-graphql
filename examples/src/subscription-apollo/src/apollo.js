import ApolloClient from "apollo-client";
import { WebSocketLink } from 'apollo-link-ws';
import { InMemoryCache } from "apollo-cache-inmemory";

import gql from 'graphql-tag'

const GRAPHQL_URI = 'elm-apollo-graphql.herokuapp.com/v1alpha1/graphql';

// Create a WebSocket link:
const wsLink = new WebSocketLink({
  uri: `wss://${GRAPHQL_URI}`,
  options: {
    reconnect: true
  }
});

export const getClient = () => {
  const client = new ApolloClient({
    link: wsLink,
    cache: new InMemoryCache({
      addTypename: true
    })
  });
  return client;
};

export default getClient;
