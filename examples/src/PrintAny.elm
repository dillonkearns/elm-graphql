-- Credit goes to wintvelt.
-- Copy pasted from https://github.com/wintvelt/elm-print-any since it hasn't been updated for 0.18


module PrintAny exposing
    ( view, log
    , config, viewWithConfig
    )

{-| A tiny library for debugging purposes.
It prints any record to the console or to the DOM.

You can simply call `PrintAny.view myRecord` inside your `view` function,
to print `myRecord` to the DOM.

Or use `PrintAny.log myRecord` anywhere, to get a (somewhat) prettified version of the record in the console.

_PS: You may not want to use this with large records.
Performance is not optimal. This module iterates over a
string version of the record, which may take long time._


# Basics

@docs view, log


# Advanced

@docs config, viewWithConfig

-}

import Html exposing (Html, p, pre, text)
import Html.Attributes exposing (class, style)
import String



{- Library constants -}


type alias Constants =
    { quote : String
    , indentChars : String
    , outdentChars : String
    , newLineChars : String
    }


constants : Constants
constants =
    { quote = "\""
    , indentChars = "[{("
    , outdentChars = "}])"
    , newLineChars = ","
    }


type Config
    = Config
        { increment : Int
        , className : String
        }


{-| Custom configuration of output to DOM.

With the `viewWithConfig` function, you can configure

  - `Int` indentation in pixels of individual lines
  - `String` class name for rendering the `<pre>` wrapper

Usage:

`viewWithConfig (config 20 "debug-record") myRecord`

Prints `record` to the DOM with the wrapper provide with class "debug-record",
and each line indented with increments of 20px.

The classname allows you to style the wrapper as well as the children elements in css.

-}
config : Int -> String -> Config
config increment className =
    Config
        { increment = increment
        , className = className
        }


{-| Default configuration

```Elm
defaultConfig =
  { increment = 20  -- 20 pixels indentation at each level
  , className = "" -- no className supplied to wrapper
  }```
```

-}
defaultConfig : Config
defaultConfig =
    Config
        { increment = 20
        , className = ""
        }


{-| renders any record to the Dom.
Usage:

```Elm
view model =
    div []
        [ text model.whatEverYouWant
        , PrintAny.view model
        ]
```

The output is a `<pre>` element.
Inside is a set of indented `<p>` elements representing your record.

-}
view : a -> Html msg
view record =
    viewWithConfig defaultConfig record


{-| renders any record to the Dom, with custom configuration.

Usage:

```Elm
view model =
    div []
        [ text model.whatEverYouWant
        , PrintAny.viewWithConfig
            PrintAny.config
            20
            "debug-record"
            model
        ]
```

-}
viewWithConfig : Config -> a -> Html msg
viewWithConfig (Config config_) record =
    let
        lines =
            record
                |> Debug.toString
                |> splitWithQuotes
                |> splitUnquotedWithChars
                |> List.concat
                |> mergeQuoted
                |> addIndents
    in
    pre
        (if config_.className == "" then
            []

         else
            [ class config_.className ]
        )
    <|
        List.map (viewLine <| Config config_) lines



{- render a single formatted line to DOM -}


viewLine : Config -> ( Int, String ) -> Html msg
viewLine (Config config_) ( indent, string ) =
    p
        [ style "paddingLeft" (px (indent * config_.increment))
        , style "marginTop" "0px"
        , style "marginBottom" "0px"
        ]
        [ text string ]


{-| Prints a stylized version of any record to the DOM.

So if you have:

```Elm
record =
    { name = "Bill"
    , friends = [ "Casey", "Dave", "Eve", "Fred" ]
    , coordinates = ( 125, 33 )
    }
```

Then `PrintAny.log record` will log to the console:

```Elm
{ name = "Bill"
, friends =
..[ "Casey"
.., "Dave"
.., "Eve"
.., "Fred"
..]
, coordinates =
..(125
..,33
..)
}
```

The function will output the original record passed, so you can do:

`myNewRecord = PrintAny.log { record | item = somethingNew }`

-}
log : a -> a
log record =
    let
        lines =
            record
                |> Debug.toString
                |> splitWithQuotes
                |> splitUnquotedWithChars
                |> List.concat
                |> mergeQuoted
                |> addIndents
                |> List.reverse
    in
    record



-- helpers


px : Int -> String
px int =
    String.fromInt int
        ++ "px"


type alias IndentedString =
    { indentBefore : Int
    , string : String
    , indentAfter : Int
    }



{- take list of strings and add indentation, based on the first character in each string -}


addIndents : List String -> List ( Int, String )
addIndents stringList =
    stringList
        |> List.foldl addIndent []
        |> List.map (\r -> ( r.indentBefore, r.string ))



{- add indent to a single Item in a list -}


addIndent : String -> List IndentedString -> List IndentedString
addIndent string startList =
    case List.reverse startList of
        { indentAfter } :: other ->
            let
                firstChar =
                    String.left 1 string

                ( newIndentBefore, newIndentAfter ) =
                    if String.contains firstChar constants.indentChars then
                        ( indentAfter + 1, indentAfter + 1 )

                    else if String.contains firstChar constants.outdentChars then
                        ( indentAfter, indentAfter - 1 )

                    else
                        ( indentAfter, indentAfter )
            in
            startList
                ++ [ { indentBefore = newIndentBefore
                     , string = string
                     , indentAfter = newIndentAfter
                     }
                   ]

        [] ->
            [ { indentBefore = 0
              , string = string
              , indentAfter = 0
              }
            ]



{- If string is not in quotes, split based on characters,
   otherwise return unsplit string in a list
-}


splitUnquotedWithChars : List String -> List (List String)
splitUnquotedWithChars stringList =
    let
        splitString string =
            if String.left 1 string == constants.quote then
                [ string ]

            else
                splitWithChars
                    (constants.indentChars ++ constants.newLineChars ++ constants.outdentChars)
                    string
    in
    List.map splitString stringList



{- split a string with each of a set of characters, keeping the characters used to split -}


splitWithChars : String -> String -> List String
splitWithChars splitters string =
    case String.left 1 splitters of
        "" ->
            [ string ]

        char ->
            string
                |> splitWithChar char
                |> List.map (splitWithChars <| String.dropLeft 1 splitters)
                |> List.concat
                |> List.filter (\s -> s /= "")



{- split a string with a character, but keep the string or character used in splitting
   So:
   `splitWithChar "," "Apples, Bananas, Coconuts" == ["Apples", ", Bananas", ", Coconuts"]`
-}


splitWithChar : String -> String -> List String
splitWithChar splitter string =
    String.split splitter string
        |> List.indexedMap
            (\ind str ->
                if ind > 0 then
                    splitter ++ str

                else
                    str
            )



{- split a string with quoted parts, but keep quotes -}


splitWithQuotes : String -> List String
splitWithQuotes string =
    String.split "\"" string
        |> List.indexedMap
            (\i str ->
                if remainderBy 2 i == 1 then
                    "\"" ++ str ++ "\""

                else
                    str
            )



{- in a list of strings, add all quoted list items to the previous item in the list -}


mergeQuoted : List String -> List String
mergeQuoted =
    List.foldl mergeOneQuote []


mergeOneQuote : String -> List String -> List String
mergeOneQuote string startList =
    if String.left 1 string == constants.quote then
        -- append the string to the last line in the list
        case List.reverse startList of
            x :: xs ->
                ((x ++ string) :: xs)
                    |> List.reverse

            [] ->
                [ string ]

    else
        -- simply add string as line to the list
        startList ++ [ string ]
