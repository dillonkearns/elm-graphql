# Fixing Other Errors

### Map.!: given key is not an element in the map

This is a compiler issue which it is possible to run into while using `dillonkearns/elm-graphql`. The error is caused by the `HttpError` type, which references `Http.Metadata`. If you do not have `elm/http` as a direct dependency in your project, the compiler will get confused and throw the error above. 

To resolve this, simply add `elm/http` as a direct dependency in your project.

You can read more about the compiler issue here https://github.com/elm/compiler/issues/1864
