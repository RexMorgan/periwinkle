module Page.Dashboard exposing (Model, Msg, init, view)

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

init : Task PageLoadError Model
init =
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
        [caseList model.cases]

caseList : List Case -> Html msg
caseList cases =
    div [ class "p2" ]
        [ table [class "table"]
            [ thead []
                [ tr []
                    [ th [] [ text "title" ]
                    , th [] [ text "status" ]
                    , th [] [ text "Employee" ]
                    , th [] [ text "Owner" ]
                    , th [] []
                    ]
                ]
            , tbody [] (List.map caseRow cases)
            ]
        ]

caseRow : Case -> Html msg
caseRow caseItem =
    tr []
        [ td [] [ text caseItem.title ]
        , td [] [ text caseItem.status ]
        , td [] [ text (getEmployeeName caseItem) ]
        , td [] [ text (getOwnerName caseItem) ]
        , td []
            [ viewBtn caseItem ]
        ]

getEmployeeName : Case -> String
getEmployeeName caseItem =
    case caseItem.employee of
        Nothing ->
            ""
        
        Just employee ->
            employee.fullName

getOwnerName : Case -> String
getOwnerName caseItem =
    case caseItem.owner of
        Nothing ->
            ""
        
        Just user ->
            user.fullName

viewBtn : Case -> Html.Html msg
viewBtn caseItem =
    a[ class "btn regular"
    , Route.href (Route.CaseView caseItem.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] []
      , text "View" ]

type Msg
  = None