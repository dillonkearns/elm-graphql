module View.QueryAndResponse exposing (view)

import Graphqelm.Field
import Html exposing (div, h1, p, pre, text)


view : Graphqelm.Field.Query a -> model -> Html.Html msg
view query model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Graphqelm.Field.toQuery query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]
