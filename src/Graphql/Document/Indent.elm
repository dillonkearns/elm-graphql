module Graphql.Document.Indent exposing (generate)


generate : Int -> String
generate indentationLevel =
    String.repeat indentationLevel "  "
