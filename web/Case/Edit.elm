module Case.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Models exposing (Case)
import Msgs exposing (Msg)
import Routing exposing (casesPath)


view : Case -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Case -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Case -> Html.Html Msg
form caseItem =
    div [ class "m3" ]
        [ h1 [] [ text caseItem.title ]
        , formLevel caseItem
        ]


formLevel : Case -> Html.Html Msg
formLevel caseItem =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString caseItem.title) ]

            ]
        ]



listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href casesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]