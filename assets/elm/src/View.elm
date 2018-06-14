module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, Case, CaseId)
import Msgs exposing (Msg)
import Case.Model
import Case.List
import RemoteData exposing (..)
import Html.Attributes exposing (..)
import Layout.Heading exposing (headingBar)


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
            caseViewPage model id

        Models.NotFoundRoute ->
            notFoundView


caseViewPage : Model -> CaseId -> Html Msg
caseViewPage model caseId =
    case model.cases of
        NotAsked ->
            text ""

        Loading ->
            text "Loading..."

        Success cases ->
            let
                maybeCase =
                    cases
                        |> List.filter (\caseItem -> caseItem.id == caseId)
                        |> List.head
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