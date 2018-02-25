## Why do I get an error when I don't provide an Optional Argument? According to the schema it's optional.

This is very common, if you look at your schema you will probably find that the optional argument is marked as nullable (i.e. it doesn't end with a `!`). And in GraphQL, a nullable argument is exactly what an optional argument is, see http://facebook.github.io/graphql/October2016/#sec-Required-Non-Null-Arguments

> Arguments can be required. Arguments are required if the type of the argument is non‐null. If it is not non‐null, the argument is optional.

But even though the schema lists the argument as optional (i.e. nullable), it's common to throw a runtime error and say that it's invalid. A common reason for this is that you must pass in "one of the following...", so no individual argument is required, but if you don't provide one it will throw a runtime error. Here's an example from the Github API (you can reporduce it yourself by running this query in [the Github Explorer](https://developer.github.com/v4/explorer/)):

![github optional argument error](https://raw.githubusercontent.com/dillonkearns/graphqelm/master/assets/github-optional-arg-error.png)
