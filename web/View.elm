module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, Case, CaseId)
import Msgs exposing (Msg)
import Case.Model
import Case.List
import RemoteData exposing (..)

view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.CasesRoute ->
            Case.List.view model.cases

        Models.CaseRoute id ->
            caseViewPage model.cases id

        Models.NotFoundRoute ->
            notFoundView


caseViewPage : WebData (List Case) -> CaseId -> Html Msg
caseViewPage model caseId =
    case model of
        NotAsked ->
            text ""

        Loading ->
            text "Loading ..."

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