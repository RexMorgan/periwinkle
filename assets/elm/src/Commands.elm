module Commands exposing (..)

import Http
import Msgs exposing (Msg)
import Models exposing (..)
import RemoteData
import ApiPaths exposing (..)

fetchCaseList : Cmd Msg
fetchCaseList =
    Http.get apiCaseList decodeCases
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchCases


getCase : String -> Cmd Msg
getCase id =
    Http.get ("/api/case/" ++ (id)) decodeCase
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchCase