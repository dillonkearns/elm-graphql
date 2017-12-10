module View.QueryAndResponse exposing (view)

import Graphqelm.Document as Document exposing (DocumentRoot)
import Html exposing (div, h1, p, pre, text)


view : DocumentRoot a -> model -> Html.Html msg
view query model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.toQuery query |> toString) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]
