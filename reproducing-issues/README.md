# Reproducing Issues

## Background

I get a lot of issues, which are all appreciated. However, it's not viable for me as a maintainer to reproduce each of them (multiply the number of users by the amount of time to get context on the problem, ask questions to get context, try to reproduce the issue, and then get context on whatever I was working on that day!). So please do the following steps before getting help for a fix. This makes development on this project a lot more sustainable. Thank you!

## Creating a minimal reproduction of possible or known issues

This folder contains some tools to help reproduce minimal examples.

After cloning this project, run this from the top-level directory of the `elm-graphql` repo:

```bash
npm run reproduce-error
```

This will take the GraphQL schema from the file `reproducing-issues/sdl.js` and generate code based on that. From there you can check if you've reproduced the issue. This helps you iterate quickly to create a minimal schema that reproduces the fix.

Then you can share the SDL snippet that created the problem.
