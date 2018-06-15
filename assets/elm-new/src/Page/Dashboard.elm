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
        (viewCases model.cases)

viewCases : (List Case) -> List (Html msg)
viewCases cases =
  List.map toLi cases

toLi : Case -> Html msg
toLi theCase =
  li [] [ text theCase.title ]

type Msg
  = None