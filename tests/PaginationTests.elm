module PaginationTests exposing (all)

import Dict
import Expect
import Graphql.Document
import Graphql.Http.GraphqlError as GraphqlError
import Graphql.Internal.Builder.Object as Object
import Graphql.Paginator as Paginator exposing (Paginator)
import Graphql.SelectionSet as SelectionSet
import Json.Decode as Decode
import Test exposing (Test, describe, test)


all : Test
all =
    describe "pagination"
        [ test "reverse pagination items are added in correct order" <|
            \() ->
                """
                {
  "data": {
        "edges": [
          {
            "node": {
              "login3832528868": "nickbytes"
            },
            "starredAt987198633": "2019-02-24T21:49:48Z"
          },
          {
            "node": {
              "login3832528868": "achou11"
            },
            "starredAt987198633": "2019-02-24T23:30:53Z"
          },
          {
            "node": {
              "login3832528868": "boxtim"
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
                    |> Decode.decodeString
                        (Paginator.selectionSet 2
                            Paginator.backward
                            (Object.selectionForCompositeField "edges" [] SelectionSet.empty (identity >> Decode.list))
                            |> Graphql.Document.decoder
                        )
                    |> expectNodes []
        ]


expectNodes : List node -> Result error (Paginator direction node) -> Expect.Expectation
expectNodes expectedNodes result =
    case result of
        Ok paginator ->
            paginator |> Paginator.nodes |> Expect.equal expectedNodes

        Err error ->
            Expect.fail (Debug.toString error)
