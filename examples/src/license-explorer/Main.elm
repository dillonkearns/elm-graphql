module Main exposing (main)

import Browser
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font
import Github.Interface.RepositoryOwner
import Github.Object
import Github.Object.License
import Github.Object.LicenseRule
import Github.Object.Repository
import Github.Object.RepositoryConnection
import Github.Query
import Github.Scalar
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Html exposing (Html)
import RemoteData exposing (RemoteData)



{-
   query licenseExplorer($owner: String!) {
     licenses {
       ...licenseOverview
       ...licenseDetails
     }
-}


type alias FullLicense =
    { overview : LicenseOverview
    , details : LicenseDetails
    }


type alias Response =
    { licenseChoices : List FullLicense
    , ownerLicenses : List RepoWithLicense
    }


licenseExplorerQuery : String -> SelectionSet Response RootQuery
licenseExplorerQuery owner =
    SelectionSet.succeed Response
        |> with
            (Github.Query.licenses
                (SelectionSet.succeed FullLicense
                    |> with fragmentLicenseOverview
                    |> with fragmentLicenseDetails
                )
                |> SelectionSet.map (List.filterMap identity)
            )
        |> with (ownerLicenses owner)



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
    SelectionSet.succeed LicenseOverview
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
    SelectionSet.succeed LicenseDetails
        |> with
            (Github.Object.License.conditions Github.Object.LicenseRule.label
                |> removeNothingsFromList
            )
        |> with
            (Github.Object.License.permissions
                Github.Object.LicenseRule.label
                |> removeNothingsFromList
            )



{-
   fragment repoWithLicense on Repository {
     name
     licenseInfo {
       ...licenseOverview
     }
   }
-}


type alias RepoWithLicense =
    { name : String
    , license : Maybe LicenseOverview
    }


fragmentRepoWithLicense =
    SelectionSet.succeed RepoWithLicense
        |> with Github.Object.Repository.name
        |> with (Github.Object.Repository.licenseInfo fragmentLicenseOverview)



{-
   repositoryOwner(login: $owner) {
      pinnedRepositories(first: 6) {
        nodes {
          ...repoWithLicense
        }
      }
    }
-}


ownerLicenses : String -> SelectionSet (List RepoWithLicense) RootQuery
ownerLicenses ownerLogin =
    Github.Query.repositoryOwner { login = ownerLogin }
        (Github.Interface.RepositoryOwner.pinnedRepositories (\input -> { input | first = Present 6 })
            (Github.Object.RepositoryConnection.nodes
                fragmentRepoWithLicense
                |> SelectionSet.nonNullOrFail
                |> removeNothingsFromList
            )
        )
        |> SelectionSet.nonNullOrFail


makeRequest =
    licenseExplorerQuery "dillonkearns"
        |> Graphql.Http.queryRequest "https://api.github.com/graphql"
        |> Graphql.Http.withHeader "authorization" "Bearer dbd4c239b0bbaa40ab0ea291fa811775da8f5b59"
        |> Graphql.Http.send (Graphql.Http.parseableErrorAsSuccess >> RemoteData.fromResult >> GotLicenses)



-- VIEW


view : Model -> Html Msg
view model =
    (case model of
        RemoteData.Success licenses ->
            Element.column
                [ Element.spacing 30
                , Element.width (Element.fill |> Element.maximum 1200)
                , Element.centerX
                , Element.padding 50
                ]
                (ownerLicensesView licenses.ownerLicenses
                    :: (licenses.licenseChoices
                            |> List.map licenseView
                       )
                )

        status ->
            status
                |> Debug.toString
                |> Element.text
    )
        |> Element.layout []


ownerLicensesView : List RepoWithLicense -> Element msg
ownerLicensesView licenses =
    Element.column [ Element.width Element.fill ] (licenses |> List.map ownerLicenseView)


ownerLicenseView : RepoWithLicense -> Element msg
ownerLicenseView repoWithLicense =
    Element.row [ Element.spaceEvenly, Element.width Element.fill ]
        [ Element.text repoWithLicense.name |> Element.el []
        , Element.text
            (repoWithLicense.license
                |> Maybe.map .name
                |> Maybe.withDefault "NO LICENSE"
            )
            |> Element.el []
        ]


licenseView : FullLicense -> Element Msg
licenseView licenseDetails =
    Element.column
        [ Element.spacing 20
        ]
        [ [ Element.text licenseDetails.overview.name
          ]
            |> Element.paragraph
                [ Element.Font.size 30
                ]
        , Element.row [ Element.spaceEvenly, Element.width Element.fill ]
            [ conditionsView "Conditions" licenseDetails.details.conditions
            ]
        ]


conditionsView titleText conditions =
    Element.column [ Element.spacing 10 ]
        [ Element.text titleText |> Element.el [ Element.Font.size 20, Element.Font.bold ]
        , Element.column []
            (List.map
                bulletView
                conditions
            )
        ]


bulletView : String -> Element msg
bulletView content =
    Element.row [ Element.spacing 5 ]
        [ Element.el
            [ Element.Background.color (Element.rgba255 0 153 214 1.0)
            , Element.width (Element.px 12)
            , Element.height (Element.px 12)
            , Element.Border.rounded 10000
            ]
            Element.none
        , Element.text content
        ]



-- APPLICATION STATE & BOILERPLATE


type alias Model =
    LicenseResponse


type Msg
    = GotLicenses LicenseResponse


type alias LicenseResponse =
    RemoteData (Graphql.Http.Error ()) Response


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( RemoteData.Loading
    , makeRequest
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotLicenses response ->
            ( response, Cmd.none )


removeNothingsFromList : SelectionSet (List (Maybe a)) typeLock -> SelectionSet (List a) typeLock
removeNothingsFromList =
    SelectionSet.map (List.filterMap identity)


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
