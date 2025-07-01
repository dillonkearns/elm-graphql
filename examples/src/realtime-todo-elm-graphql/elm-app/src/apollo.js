import ApolloClient from "apollo-client";
import { split } from 'apollo-link';
import { HttpLink } from 'apollo-link-http';
import { WebSocketLink } from 'apollo-link-ws';
import { getMainDefinition } from 'apollo-utilities';
import { InMemoryCache } from "apollo-cache-inmemory";

import gql from 'graphql-tag'

const GRAPHQL_URI = 'graphql-engine-test-1.herokuapp.com/v1alpha1/graphql';

// Create a WebSocket link:
const wsLink = new WebSocketLink({
  uri: `ws://${GRAPHQL_URI}`,
  options: {
    reconnect: true
  }
});

const getClient = () => {
  const client = new ApolloClient({
    link: wsLink,
    cache: new InMemoryCache({
      addTypename: true
    })
  });
  return client;
};

export default getClient;
