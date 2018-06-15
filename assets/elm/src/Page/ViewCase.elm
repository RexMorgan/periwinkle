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

type alias Model
    = Case


init : Case.CaseId -> Task PageLoadError Model
init id =
  let
      loadCase =
        Request.Cases.get id
          |> Http.toTask

      handleLoadError _ =
        pageLoadError (Page.ViewCase id) "Shits broke."
  in
    loadCase
      |> Task.mapError handleLoadError

-- VIEW --
view : Case -> Html msg
view model =
    div [ class "viewCase" ]
        [viewCase model]

viewCase : Case -> Html msg
viewCase model =
    div[]
        [
            div[class "columns"]
                [
                    span[class "column is-1"]
                        [text "Title:"]
                        , span[class "column"]
                            [text model.title]
                ]
            , div[class "columns"]
                [
                    span[class "column is-1"]
                        [text "Status:"]
                        , span[class "column"]
                            [text model.status]
                ]
        ]

type Msg
  = None