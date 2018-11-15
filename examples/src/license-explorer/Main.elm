module Main exposing (main)

import Browser
import Element exposing (Element)
import Element.Background
import Github.Object
import Github.Object.License
import Github.Object.LicenseRule
import Github.Query
import Github.Scalar
import Graphql.Field as Field exposing (Field)
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, fieldSelection, with, withFragment)
import Html exposing (Html)
import RemoteData exposing (RemoteData)


removeNothingsFromList : Field (List (Maybe a)) typeLock -> Field (List a) typeLock
removeNothingsFromList =
    Field.map (List.filterMap identity)


makeRequest =
    licenseExplorerQuery "dillonkearns"
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



{-
   query licenseExplorer($owner: String!) {
     licenses {
       ...licenseOverview
       ...licenseDetails
     }
-}


licenseExplorerQuery : String -> SelectionSet (List FullLicense) RootQuery
licenseExplorerQuery owner =
    Github.Query.licenses
        (Github.Object.License.selection FullLicense
            |> withFragment fragmentLicenseOverview
            |> withFragment fragmentLicenseDetails
        )
        |> Field.map (List.filterMap identity)
        |> fieldSelection


type alias FullLicense =
    { overview : LicenseOverview
    , details : LicenseDetails
    }



{-
   fragment licenseOverview on License {
     name
     nickname
     url
   }
-}


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



{-
   fragment licenseDetails on License {
     conditions {
       description
     }
     permissions {
       description
     }
   }
-}


type alias LicenseDetails =
    { conditions : List String
    , permissions : List String
    }


fragmentLicenseDetails : SelectionSet LicenseDetails Github.Object.License
fragmentLicenseDetails =
    Github.Object.License.selection LicenseDetails
        |> with
            (Github.Object.License.conditions (fieldSelection Github.Object.LicenseRule.label)
                |> removeNothingsFromList
            )
        |> with
            (Github.Object.License.permissions
                (fieldSelection Github.Object.LicenseRule.label)
                |> removeNothingsFromList
            )


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
