-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Github.Enum.PullRequestReviewEvent exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-| The possible events to perform on a pull request review.

  - Comment - Submit general feedback without explicit approval.
  - Approve - Submit feedback and approve merging these changes.
  - RequestChanges - Submit feedback that must be addressed before merging.
  - Dismiss - Dismiss review so it now longer effects merging.

-}
type PullRequestReviewEvent
    = Comment
    | Approve
    | RequestChanges
    | Dismiss


list : List PullRequestReviewEvent
list =
    [ Comment, Approve, RequestChanges, Dismiss ]


decoder : Decoder PullRequestReviewEvent
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "COMMENT" ->
                        Decode.succeed Comment

                    "APPROVE" ->
                        Decode.succeed Approve

                    "REQUEST_CHANGES" ->
                        Decode.succeed RequestChanges

                    "DISMISS" ->
                        Decode.succeed Dismiss

                    _ ->
                        Decode.fail ("Invalid PullRequestReviewEvent type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : PullRequestReviewEvent -> String
toString enum____ =
    case enum____ of
        Comment ->
            "COMMENT"

        Approve ->
            "APPROVE"

        RequestChanges ->
            "REQUEST_CHANGES"

        Dismiss ->
            "DISMISS"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe PullRequestReviewEvent
fromString enumString____ =
    case enumString____ of
        "COMMENT" ->
            Just Comment

        "APPROVE" ->
            Just Approve

        "REQUEST_CHANGES" ->
            Just RequestChanges

        "DISMISS" ->
            Just Dismiss

        _ ->
            Nothing
