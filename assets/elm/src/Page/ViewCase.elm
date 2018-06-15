module Page.ViewCase exposing (Model, Msg, init, view)

import Data.Case as Case exposing (Case)
import Html exposing (..)
import Html.Attributes exposing (attribute, class, classList, href, id, placeholder)
import Page.Errored exposing (PageLoadError, pageLoadError)
import Request.Cases
import Html.Events exposing (onClick)
import Http
import Task exposing (Task)
import Util exposing ((=>), onClickStopPropagation)
import Views.Page as Page
import Route exposing (href, Route(..))

-- MODEL --

type alias Model =
  { cases : List Case
  }


init : Case.CaseId -> Task PageLoadError Model
init id =
  let
      loadCases =
        Request.Cases.list
          |> Http.toTask

      handleLoadError _ =
        pageLoadError Page.Dashboard "Shits broke."
  in
  Task.map Model loadCases
    |> Task.mapError handleLoadError

-- VIEW --
view : Model -> Html msg
view model =
    div [ class "dashboard" ]
        (viewCases model.cases)

viewCases : (List Case) -> List (Html msg)
viewCases cases =
  List.map toLi cases

toLi : Case -> Html msg
toLi theCase =
  li [] [ text theCase.title ]

list : List Case -> Html Msg
list cases =
    div [ class "p2" ]
        [ table [class "table"]
            [ thead []
                [ tr []
                    [ th [] [ text "title" ]
                    , th [] [ text "status" ]
                    , th [] []
                    ]
                ]
            , tbody [] (List.map caseRow cases)
            ]
        ]

caseRow : Case -> Html Msg
caseRow caseItem =
    tr []
        [ td [] [ text caseItem.title ]
        , td [] [ text caseItem.status ]
        , td []
            [ viewBtn caseItem ]
        ]


viewBtn : Case -> Html.Html Msg
viewBtn caseItem =
    a[ class "btn regular"
    , Route.href (Route.CaseView caseItem.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] []
      , text "View" ]

type Msg
  = None