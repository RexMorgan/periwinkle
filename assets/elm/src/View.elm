module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, Case, CaseId)
import Msgs exposing (Msg)
import Case.Model
import Case.List
import RemoteData exposing (..)
import Html.Attributes exposing (..)
import Layout.Heading exposing (headingBar)
import Commands exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ headerArea
          , pageArea model ]

pageArea : Model -> Html Msg
pageArea model =
    div[class "container"]
        [
            contentArea model
            , footerArea
        ]


contentArea : Model -> Html Msg
contentArea model =
    div[]
        [
            page model
        ]


headerArea : Html Msg
headerArea =
    div[]
        [
            headingBar
        ]

footerArea : Html Msg
footerArea =
    div[]
        [

        ]


sidebarArea : Html Msg
sidebarArea =
    div[]
        [

        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.CasesRoute ->
            Case.List.view model.cases

        Models.CaseRoute id ->
            getCase id
            |>  caseViewPage

        Models.NotFoundRoute ->
            notFoundView

caseViewPage : WebData Case -> Html Msg
caseViewPage model =
    case model of
        NotAsked ->
            text ""

        Loading ->
            text "Loading..."

        Success caseObj ->
            let
                maybeCase =
                    Maybe.map caseObj
            in
                case maybeCase of
                    Just caseObj ->
                        Case.Model.viewCase caseObj

                    Nothing ->
                        notFoundView

        Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]