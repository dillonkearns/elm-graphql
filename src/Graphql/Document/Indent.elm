module Graphql.Document.Indent exposing (generate)


generate : Int -> String
generate indentationLevel =
    spaces (indentationLevel * 2)


spaces : Int -> String
spaces n =
    if n > 0 then
        " " ++ spaces (n - 1)

    else
        ""
