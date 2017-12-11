module View.QueryAndResponse exposing (view)

import Graphqelm.Field exposing (fieldDecoderToQuery)
import Html exposing (div, h1, p, pre, text)


-- view : Graphqelm.Field.FieldDecoder decodesTo typeLock -> model -> Html.Html msg


view : Graphqelm.Field.FieldDecoder decodesTo typeLock -> a -> Html.Html msg
view query model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Graphqelm.Field.toQuery query |> toString) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]
