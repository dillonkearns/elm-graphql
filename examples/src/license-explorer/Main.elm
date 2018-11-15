module Main exposing (main)

import Browser
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Events
import ElmPackage
import Github.Object
import Github.Object.License
import Github.Object.LicenseRule
import Github.Query
import Github.Scalar
import Graphql.Document as Document
import Graphql.Field as Field exposing (Field)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, fieldSelection, with, withFragment)
import Html exposing (Html, a, button, div, h1, img, p, pre, text)
import Html.Attributes exposing (href, src, style, target)
import Html.Events exposing (onClick)
import Http
import PrintAny
import RemoteData exposing (RemoteData)
import RepoWithOwner
import View.Result


type alias FullLicense =
    { overview : LicenseOverview
    , details : LicenseDetails
    }


type alias LicenseOverview =
    { name : String
    , key : String
    , url : Maybe Github.Scalar.Uri
    }


fragmentLicenseOverview : SelectionSet LicenseOverview Github.Object.License
fragmentLicenseOverview =
    Github.Object.License.selection LicenseOverview
        |> with Github.Object.License.name
        |> with Github.Object.License.key
        |> with Github.Object.License.url


type alias LicenseDetails =
    { conditions : List String
    }


fragmentLicenseDetails : SelectionSet LicenseDetails Github.Object.License
fragmentLicenseDetails =
    Github.Object.License.selection LicenseDetails
        |> with
            (Github.Object.License.conditions (fieldSelection Github.Object.LicenseRule.label)
                |> removeNothingsFromList
            )


removeNothingsFromList : Field (List (Maybe a)) typeLock -> Field (List a) typeLock
removeNothingsFromList =
    Field.map (List.filterMap identity)


makeRequest =
    query
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (Graphql.Http.parseableErrorAsSuccess >> RemoteData.fromResult >> GotLicenses)


type Msg
    = GotLicenses LicenseResponse


type alias LicenseResponse =
    RemoteData (Graphql.Http.Error ()) (List FullLicense)


type alias Model =
    { licenses : LicenseResponse
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { licenses = RemoteData.Loading
      }
    , makeRequest
    )


fullLicenseSelection =
    Github.Object.License.selection FullLicense
        |> withFragment fragmentLicenseOverview
        |> withFragment fragmentLicenseDetails


query : SelectionSet (List FullLicense) RootQuery
query =
    Github.Query.licenses fullLicenseSelection
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


licenseView : FullLicense -> Element Msg
licenseView licenseDetails =
    Element.row [ Element.spaceEvenly, Element.width Element.fill ]
        [ Element.text licenseDetails.overview.name
        , Element.text licenseDetails.overview.key
        , licenseDetails.details.conditions |> Debug.toString |> Element.text
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
