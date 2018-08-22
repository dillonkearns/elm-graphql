const webpack = require("webpack");
const path = require("path");

module.exports = {
  entry: "./generator/src/elm-graphql.ts",
  target: "node",
  resolve: {
    extensions: [".ts", ".js", ".json"]
  },
  node: {
    __dirname: false
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
    publicPath: "/"
  },
  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: "elm-webpack-loader",
            options: { cwd: './generator' }
          }
        ]
      },
      { test: /\.ts$/, loader: "ts-loader" }
    ]
  }
};
