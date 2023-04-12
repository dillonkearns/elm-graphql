# realtime-todo-elm-graphql

A demo to showcase real-time capabilities of GraphQL using graphql-elm and apollo-client

The application makes use of Hasura GraphQL Engine's real-time capabilities
using `subscription`. There is no backend code involved. The application is
hosted on GitHub pages and the Postgres+GraphQL Engine is running on Postgres.

# Running the app yourself

- Deploy Postgres and GraphQL Engine on Heroku:
  
  [![Deploy to
  heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/hasura/graphql-engine-heroku)
- Get the Heroku app URL (say `todo-mvc-elm-backend1.herokuapp.com`)
- Clone this repo:
  ```bash
  git clone git@github.com:karthikvt26/elm-graphql.git


  cd elm-graphql/examples/src/realtime-todo-elm-graphql/elm-app
  ```
- [Install Hasura CLI](https://docs.hasura.io/1.0/graphql/manual/hasura-cli/install-hasura-cli.html)
- Goto `hasura/` and edit `config.yaml`:
  ```yaml
  endpoint: https://todo-mvc-elm-backend1.herokuapp.com
  ```
- Apply the migrations:
  ```bash
  hasura migrate apply
  ```
- Edit `graphql_url` in `src/Main.elm`, `GRAPHQL_URI` in `src/index.js` and set it to the
  Heroku app URL:
  ```js
  export const HASURA_GRAPHQL_URL = 'todo-mvc-elm-backend1.herokuapp.com/v1alpha1/graphql';
  ```
- Run the app (go to the root of the repo):
  ```bash
  npm start
  ```
