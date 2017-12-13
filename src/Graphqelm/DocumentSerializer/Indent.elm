module Graphqelm.DocumentSerializer.Indent exposing (generate)


generate : Bool -> Int -> String
generate skip indentationLevel =
    if skip then
        ""
    else
        spaces (indentationLevel * 2)


spaces : Int -> String
spaces n =
    if n > 0 then
        " " ++ spaces (n - 1)
    else
        ""
