module GenerateSyntax exposing (typeAlias)

import String.Interpolate exposing (interpolate)


typeAlias : List ( String, String ) -> String
typeAlias entries =
    entries
        |> List.map (\( key, value ) -> key ++ " : " ++ value)
        |> String.join "\n , "
        |> List.singleton
        |> interpolate "{ {0} }"
