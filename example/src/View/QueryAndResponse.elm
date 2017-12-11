module View.QueryAndResponse exposing (view)

import Graphqelm.Document as Document exposing (DocumentRoot)
import Graphqelm.Object exposing (Object)
import Html exposing (div, h1, p, pre, text)


-- view : FieldDecoder decodesTo typeLock -> model -> Html.Html msg


view : Object decodesTo typeLock -> a -> Html.Html msg
view query model =
    div []
        [ div []
            [ h1 [] [ text "Generated Query" ]
            , pre [] [ text (Document.toQueryNew query) ]
            ]
        , div []
            [ h1 [] [ text "Response" ]
            , Html.text (toString model)
            ]
        ]
