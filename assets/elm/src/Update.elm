module Update exposing (..)

import Models exposing (Model, Case)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchCases response ->
            ( { model | cases = response }, Cmd.none )

        Msgs.OnFetchCase response ->
            ( { model | caseObj = response}, Cmd.none)

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )