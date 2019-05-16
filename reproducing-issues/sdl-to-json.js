const graphql = require("graphql");
const sdlSchema = require("./sdl.js");

console.log(
  JSON.stringify(
    graphql.introspectionFromSchema(graphql.buildSchema(sdlSchema)),
    null,
    2
  )
);
