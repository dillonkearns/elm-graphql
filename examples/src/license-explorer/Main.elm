module Main exposing (main)

import Browser
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Events
import ElmPackage
import Github.Object
import Github.Object.License
import Github.Query
import Github.Scalar
import Graphql.Document as Document
import Graphql.Field as Field exposing (Field)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, fieldSelection, with)
import Html exposing (Html, a, button, div, h1, img, p, pre, text)
import Html.Attributes exposing (href, src, style, target)
import Html.Events exposing (onClick)
import Http
import PrintAny
import RemoteData exposing (RemoteData)
import RepoWithOwner
import View.Result


type alias LicenseOverview =
    { name : String
    , key : String

    -- , nickname : Maybe String
    -- , url : Maybe Github.Scalar.Uri
    }


fragmentLicenseOverview : SelectionSet LicenseOverview Github.Object.License
fragmentLicenseOverview =
    Github.Object.License.selection LicenseOverview
        |> with Github.Object.License.name
        |> with Github.Object.License.key



-- |> with Github.Object.License.nickname
-- |> with Github.Object.License.url


makeRequest =
    query
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (Graphql.Http.parseableErrorAsSuccess >> RemoteData.fromResult >> GotLicenses)


type Msg
    = GotLicenses (RemoteData (Graphql.Http.Error ()) (List LicenseOverview))


type alias Model =
    { licenses : RemoteData (Graphql.Http.Error ()) (List LicenseOverview)
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { licenses = RemoteData.Loading
      }
    , makeRequest
    )


query =
    Github.Query.licenses fragmentLicenseOverview
        |> Field.map (List.filterMap identity)
        |> fieldSelection


view : Model -> Html Msg
view model =
    (case model.licenses of
        RemoteData.Success licenses ->
            Element.column
                [ Element.spacing 30
                , Element.width (Element.fill |> Element.maximum 1200)
                , Element.centerX
                , Element.padding 50
                ]
                (licenses
                    |> List.map licenseView
                )

        status ->
            status
                |> Debug.toString
                |> Element.text
    )
        |> Element.layout []


licenseView : LicenseOverview -> Element Msg
licenseView licenseOverview =
    Element.row [ Element.spaceEvenly, Element.width Element.fill ]
        [ Element.text licenseOverview.name
        , Element.text licenseOverview.key
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotLicenses response ->
            ( { model | licenses = response }, Cmd.none )


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
