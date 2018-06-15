module Main exposing (main)

import Data.Case exposing (CaseId)
import Html exposing (..)
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)
import Page.Errored as Errored exposing (PageLoadError)
import Page.Dashboard as Dashboard
import Route exposing (Route)
import Task
import Util exposing ((=>))
import Views.Page as Page exposing (ActivePage)

type Page
  = Blank
  | Errored PageLoadError
  | NotFound
  | Dashboard Dashboard.Model

type PageState
  = Loaded Page
  | TransitioningFrom Page

type alias Model =
  { pageState : PageState }

init : Value -> Location -> ( Model, Cmd Msg )
init val location =
  setRoute (Route.fromLocation location)
  { pageState = Loaded initialPage }

initialPage : Page
initialPage =
  Blank

view : Model -> Html Msg
view model =
  case model.pageState of
    Loaded page ->
      viewPage False page
    TransitioningFrom page ->
      viewPage True page

viewPage : Bool -> Page -> Html Msg
viewPage isLoading page =
  let
    frame =
      Page.frame isLoading
  in
  case page of
    Blank ->
      Html.text ""
        |> frame Page.Other
    
    Errored subModel ->
      Errored.view subModel
        |> frame Page.Other

    NotFound ->
      Html.text "Not Found"
        |> frame Page.Other

    Dashboard subModel ->
      Dashboard.view subModel
        |> frame Page.Other
        |> Html.map DashboardMsg
    
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ pageSubscriptions ( getPage model.pageState )
    ]

getPage : PageState -> Page
getPage pageState =
  case pageState of
    Loaded page ->
      page
    TransitioningFrom page ->
      page

pageSubscriptions : Page -> Sub Msg
pageSubscriptions page =
  case page of
    Blank ->
      Sub.none
    
    Dashboard _ ->
      Sub.none

    Errored _ ->
      Sub.none

    NotFound ->
      Sub.none


type Msg
  = SetRoute (Maybe Route)
  | DashboardLoaded (Result PageLoadError Dashboard.Model)
  | DashboardMsg Dashboard.Msg

setRoute : Maybe Route -> Model -> ( Model, Cmd Msg)
setRoute maybeRoute model =
  let
    transition toMsg task =
      {model | pageState = TransitioningFrom (getPage model.pageState) }
        => Task.attempt toMsg task
    
    errored =
      pageErrored model
  in
  case maybeRoute of
    Nothing ->
      { model | pageState = Loaded NotFound } => Cmd.none

    Just Route.Dashboard ->
      transition DashboardLoaded (Dashboard.init)

    Just Route.Root ->
      transition DashboardLoaded (Dashboard.init)

pageErrored : Model -> ActivePage -> String -> ( Model, Cmd msg)
pageErrored model activePage errorMessage =
  let
    error =
      Errored.pageLoadError activePage errorMessage
  in
  { model | pageState = Loaded (Errored error) } => Cmd.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  updatePage (getPage model.pageState) msg model

updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
  let
    toPage toModel toMsg subUpdate subMsg subModel =
      let 
        ( newModel, newCmd ) =
          subUpdate subMsg subModel
      in
      ( { model | pageState = Loaded (toModel newModel) }, Cmd.map toMsg newCmd)

    errored =
      pageErrored model
  in
    case (msg, page) of
      ( SetRoute route, _ ) ->
        setRoute route model
      
      ( DashboardLoaded (Ok subModel), _ ) ->
        { model | pageState = Loaded (Dashboard subModel) } => Cmd.none
      
      ( DashboardLoaded (Err error), _ ) ->
        { model | pageState = Loaded (Errored error) } => Cmd.none

      ( _, NotFound ) ->
        -- Disregard incoming messages when we're on the
        -- NotFound page.
        model => Cmd.none

      ( _, _ ) ->
        -- Disregard incoming messages that arrived for the wrong page
        model => Cmd.none

main : Program Value Model Msg
main =
  Navigation.programWithFlags (Route.fromLocation >> SetRoute)
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }