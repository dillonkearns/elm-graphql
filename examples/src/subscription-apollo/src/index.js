import './main.css';
import { Elm } from './Main.elm';
import gql from 'graphql-tag'

import {
  getClient
} from './apollo.js';

document.addEventListener("DOMContentLoaded", function() {
  var app = Elm.Main.init({
    node: document.getElementById('root')
  });
  app.ports.createSubscriptionToAuthors.subscribe(function(data) {
    /* Initiate subscription request */
    app.ports.subscribingToAuthor.send(true);
    getClient().subscribe({
      query: gql`${data}`,
      variables: {}
    }).subscribe({
      next(resp) {
        app.ports.gotAuthorsData.send(resp);
      },
      error(err) {
        app.ports.gotAuthorsData.send(err);
      }
    });
  });
})
