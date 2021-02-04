const webpack = require("webpack");
const path = require("path");
const MODE =
  process.env.npm_lifecycle_event === "build" ? "production" : "development";

module.exports = function(env) {
  return {
    mode: MODE,
    entry: "./index.js",
    output: {
      path: path.resolve(__dirname, "dist"),
      filename: "bundle.js"
    },
    plugins:
      MODE === "development"
        ? [
            // Suggested for hot-loading
            new webpack.NamedModulesPlugin(),
            // Prevents compilation errors causing the hot loader to lose state
            new webpack.NoEmitOnErrorsPlugin()
          ]
        : [],
    module: {
      rules: [
        {
          test: /\.html$/,
          exclude: /node_modules/,
          loader: "file-loader?name=[name].[ext]"
        },
        {
          test: [/\.elm$/],
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            { loader: "elm-hot-webpack-loader" },
            {
              loader: "elm-webpack-loader",
              options:
                MODE === "production" ? {} : { debug: true, forceWatch: true }
            }
          ]
        }
      ]
    },
    resolve: {
      extensions: [".js", ".elm"]
    },
    serve: {
      inline: true,
      stats: "errors-only"
    }
  };
};
