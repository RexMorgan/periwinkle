module Case.List exposing (..)

import RemoteData exposing (WebData)
import Models exposing (Model, Case, decodeCase, Route(..))
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Routing exposing (casePath)


view : WebData (List Case) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Cases" ] ]


maybeList : WebData (List Case) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success cases ->
            list cases

        RemoteData.Failure error ->
            text (toString error)


list : List Case -> Html Msg
list cases =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "id" ]
                    , th [] [ text "title" ]
                    , th [] [ text "status" ]
                    ]
                ]
            , tbody [] (List.map caseRow cases)
            ]
        ]

caseRow : Case -> Html Msg
caseRow caseItem =
    tr []
        [ td [] [ text caseItem.id ]
        , td [] [ text caseItem.title ]
        , td [] [ text caseItem.status ]
        , td []
            [ viewBtn caseItem ]
        ]


viewBtn : Case -> Html.Html Msg
viewBtn caseItem =
    let
        path =
            casePath caseItem.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "View" ]
