module Example07CustomCodecs exposing (main)

import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Helpers.Main
import RemoteData exposing (RemoteData)
import Swapi.Enum.Language as Language
import Swapi.Interface.Character as Character
import Swapi.Query as Query
import Time



{-

   If we generated this code without specifying `--scalar-codecs CustomScalarCodecs`
   then all scalars in our schema would be deseriarlized as a Strings.
   Note that the default decoder checks if it is a primitive type, and
   serializes that primitive to a String. See the full implementation:
   https://github.com/dillonkearns/elm-graphql/blob/376e8ed0992584d9de0a9da539833c41dbeca4dd/src/Graphql/Internal/Builder/Object.elm#L21-L40

   Since we supplied a custom decoder with `--scalar-codecs CustomScalarCodecs`,
   it uses the decoder specified in that file for our schema's `PosixTime` scalar.
   So when we grab `Query.now`, instead of gettting back the default, which is
   a simple type wrapper like this: `type PosixTime = PosixTime String`, we get
   back an actual Elm `Time.Posix`. See the decoder specified in this file:
   https://github.com/dillonkearns/elm-graphql/blob/master/examples/src/CustomScalarCodecs.elm

   Since we have a `Posix.Time`, we can use some functions that require a `Posix.Time`,
   in this case `Time.toSecond Time.utc <Posix.Time value>`.

   Note that the purpose of a custom Scalar in GraphQL is to codify a set of
   assumptions that we can make about any values that are passed as arguments
   or return values of that type in our GraphQL API. The way this is enforced
   is through the custom resolvers we define to serialize and deserialize this values
   in our server. For example, if we have an `ISO8061Date` custom scalar in our
   API, we can define a deserializer that gives a nice error message if you pass
   an argument that isn't of the proper format to an API endpoint. Or if it
   is in the proper format, it converts it to a DateTime object in our server
   language that we can assume we have. Similarly, on the client side, if
   the server has sent us back an `ISO8061Date` custom scalar, we know that
   we can safely deserialize it assuming that it is in that format, since the
   server uses its `ISO8061Date` resolver to turn it into a String in that format.
   To learn more about GraphqL Scalars, see these resources:
   * https://graphql.org/learn/schema/#scalar-types
   * https://www.howtographql.com/graphql-scala/5-custom_scalars/

-}


type alias Response =
    Int


query : SelectionSet Response RootQuery
query =
    Query.now |> SelectionSet.map (Time.toSecond Time.utc)


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
