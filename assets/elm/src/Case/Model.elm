module Case.Model exposing (..)

import RemoteData exposing (WebData, RemoteData(..), asCmd, fromTask)
import Http exposing (get, toTask)
import Task exposing (Task, andThen, attempt, perform)
import Html exposing (..)
import String
import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (Msg)


-- View
view : (WebData Case) -> Html msg
view model =
    case model of
        NotAsked ->
            text ""

        Loading ->
            text "Loading: "

        Failure err ->
            text ("Error: " ++ toString err)

        Success result -> viewCase result


viewCase : Case -> Html msg
viewCase model =
    div[]
        [text(toString model)]

