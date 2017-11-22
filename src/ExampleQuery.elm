module ExampleQuery exposing (query)

import Schema.User as User


query : number
query =
    User.user [ User.id 123 ] []
