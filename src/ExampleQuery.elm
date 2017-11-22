module ExampleQuery exposing (query)

import Schema.Human as Human


query : number
query =
    Human.human
        [ Human.id "1000" ]
        [ Human.name ]
