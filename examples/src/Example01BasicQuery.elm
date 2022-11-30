module Example01BasicQuery exposing (main)

import CustomScalarCodecs exposing (Id)
import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Interface
import Swapi.Interface.Character as Character
import Swapi.Query as Query



{-

   The `query` definition in our Elm code
   is using our `characterInfoSelection` `SelectionSet`
   that we define lower down in our Elm code.
   The equivalent raw GraphQL would look like this:


   query {
     hero {
       ...characterInfo
     }
   }

-}


type alias Response =
    Character


query : SelectionSet Response RootQuery
query =
    -- We use `identity` to say that we aren't giving any
    -- optional arguments to `hero`. Read this blog post for more:
    -- https://medium.com/@zenitram.oiram/graphqelm-optional-arguments-in-a-language-without-optional-arguments-d8074ca3cf74
    Query.hero identity characterInfoSelection



{-

   `characterInfoSelection` below is equivalent to defining
   a fragment like this in raw GraphQL:


    fragment characterInfo on Character {
      name
      id
      friends {
        name
      }
    }

-}


type alias Character =
    { name : String
    , id : Id
    , friends : List String
    }



{- Check out this page to learn more about how Record Constructor Functions
   like `Character` in this example are used as the first argument to `selection`s:
   https://dillonkearns.gitbooks.io/elm-graphql/content/selection-sets.html
-}


characterInfoSelection : SelectionSet Character Swapi.Interface.Character
characterInfoSelection =
    SelectionSet.map3 Character
        Character.name
        Character.id
        (Character.friends Character.name)


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.onrender.com"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)



-- Elm Architecture Setup


type Msg
    = GotResponse Model


type alias Model =
    RemoteData (Graphql.Http.Error Response) Response


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading, makeRequest )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse response ->
            ( response, Cmd.none )


main : Helpers.Main.Program Flags Model Msg
main =
    Helpers.Main.document
        { init = init
        , update = update
        , queryString = Document.serializeQuery query
        }
