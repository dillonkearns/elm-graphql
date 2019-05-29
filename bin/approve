#!/usr/bin/env bash

set -o errexit

cd "$(dirname "${BASH_SOURCE[0]}")/.."

npm uninstall -g elm-graphql
npm run build
rm -f dillonkearns-elm-graphql-*.tgz
npm pack
npm install -g dillonkearns-elm-graphql-*.tgz
rm dillonkearns-elm-graphql-*.tgz
elm-graphql --version

cd examples
elm-graphql --introspection-file github-schema.json --base Github --output src
elm-graphql https://elm-graphql.herokuapp.com/api --base Swapi --scalar-codecs CustomScalarCodecs --output src
npx elm-analyse |  grep -v 'INFO: '

cd ../ete_tests
elm-graphql https://elm-graphql-normalize.herokuapp.com/api --base Normalize --output src

cd ..
echo 'Ensuring documentation is valid...'
npx elm make --docs=documentation.json

echo 'Confirming that generated code has been commited...'
changed_files=$(git diff --name-only)

if [[ -n $changed_files ]]; then
  echo 'FAILURE'
  echo 'Generated code has changed. Commit changes to approve.'
  echo $changed_files
  exit 1;
fi

npm run approve-compilation

echo 'SUCCESS'
