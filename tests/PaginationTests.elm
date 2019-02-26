module PaginationTests exposing (all)

import Dict
import Expect
import Graphql.Document
import Graphql.Http.GraphqlError as GraphqlError
import Graphql.Internal.Builder.Object as Object
import Graphql.Paginator as Paginator exposing (Paginator)
import Graphql.SelectionSet as SelectionSet
import Json.Decode as Decode
import String.Interpolate exposing (interpolate)
import Test exposing (Test, describe, test)


all : Test
all =
    describe "pagination"
        [ describe "backward"
            [ test "reverse pagination items are added in correct order" <|
                \() ->
                    backwardPageOfRequests "3rd" "2nd" "1st"
                        |> Decode.decodeString
                            (Paginator.selectionSet 3 Paginator.backward edgesSelection |> Graphql.Document.decoder)
                        |> expectPaginator (ExpectStillLoading [ "1st", "2nd", "3rd" ])
            , test "reverse pagination items are added in correct order after second request" <|
                \() ->
                    backwardPageOfRequests "3rd" "2nd" "1st"
                        |> Decode.decodeString (Paginator.selectionSet 3 Paginator.backward edgesSelection |> Graphql.Document.decoder)
                        |> Result.andThen
                            (\paginator ->
                                backwardPageOfRequests "6" "5" "4"
                                    |> Decode.decodeString (Paginator.selectionSet 3 paginator edgesSelection |> Graphql.Document.decoder)
                            )
                        |> expectPaginator (ExpectStillLoading [ "1st", "2nd", "3rd", "4", "5", "6" ])
            ]
        , describe "forward"
            [ test "paginated items are added in correct order" <|
                \() ->
                    forwardPageOfRequests "3rd" "2nd" "1st"
                        |> Decode.decodeString
                            (Paginator.selectionSet 3 Paginator.forward edgesSelection |> Graphql.Document.decoder)
                        |> expectPaginator (ExpectDoneLoading [ "1st", "2nd", "3rd" ])
            ]
        ]


backwardPageOfRequests : String -> String -> String -> String
backwardPageOfRequests item1 item2 item3 =
    interpolate
        """
                        {
          "data": {
                "edges": [
                  {
                    "node": {
                      "login3832528868": "{0}"
                    },
                    "starredAt987198633": "2019-02-24T21:49:48Z"
                  },
                  {
                    "node": {
                      "login3832528868": "{1}"
                    },
                    "starredAt987198633": "2019-02-24T23:30:53Z"
                  },
                  {
                    "node": {
                      "login3832528868": "{2}"
                    },
                    "starredAt987198633": "2019-02-25T00:26:03Z"
                  }
                ],
                "pageInfo": {
                  "startCursor12867311": "Y3Vyc29yOnYyOpIAzglq1vk=",
                  "hasPreviousPage3880003826": true
                }
          }
        }
                        """
        [ item1, item2, item3 ]


forwardPageOfRequests : String -> String -> String -> String
forwardPageOfRequests item1 item2 item3 =
    interpolate
        """
        {
  "data": {
        "edges": [
          {
            "cursor": "Y3Vyc29yOnYyOpIAzglq1vk=",
            "node": {
              "login3832528868": "{0}"
            },
            "starredAt987198633": "2019-02-24T21:49:48Z"
          },
          {
            "cursor": "Y3Vyc29yOnYyOpIAzglq7e0=",
            "node": {
              "login3832528868": "{1}"
            },
            "starredAt987198633": "2019-02-24T23:30:53Z"
          },
          {
            "cursor": "Y3Vyc29yOnYyOpIAzglq-Mo=",
            "node": {
              "login3832528868": "{2}"
            },
            "starredAt987198633": "2019-02-25T00:26:03Z"
          }
        ],
        "pageInfo": {
          "endCursor12867311": "Y3Vyc29yOnYyOpIAzglq-Mo=",
          "hasNextPage3880003826": false
        }
  }
}
                        """
        [ item1, item2, item3 ]


edgesSelection =
    Object.selectionForCompositeField "edges" [] loginFieldTotal (identity >> Decode.list)


loginFieldTotal =
    Object.selectionForCompositeField "node" [] loginField identity


loginField =
    Object.selectionForField "String" "login" [] Decode.string


type PaginationExpection node
    = ExpectStillLoading (List node)
    | ExpectDoneLoading (List node)


expectPaginator : PaginationExpection node -> Result error (Paginator direction node) -> Expect.Expectation
expectPaginator expectation result =
    case expectation of
        ExpectStillLoading expectedNodes ->
            case result of
                Ok paginator ->
                    { moreToLoad = paginator |> Paginator.moreToLoad
                    , nodes = paginator |> Paginator.nodes
                    }
                        |> Expect.equal
                            { moreToLoad = True
                            , nodes = expectedNodes
                            }

                Err error ->
                    Expect.fail (Debug.toString error)

        ExpectDoneLoading expectedNodes ->
            case result of
                Ok paginator ->
                    { moreToLoad = paginator |> Paginator.moreToLoad
                    , nodes = paginator |> Paginator.nodes
                    }
                        |> Expect.equal
                            { moreToLoad = False
                            , nodes = expectedNodes
                            }

                Err error ->
                    Expect.fail (Debug.toString error)
