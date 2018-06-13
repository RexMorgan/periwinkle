module Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData exposing (WebData)

type alias CaseId =
    String

type alias Case =
    {   id: CaseId
        , title: String
        , description: String
    }

type alias Model =
    { cases : WebData (List Case)
    , caseObj : WebData Case
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { cases = RemoteData.Loading
    , caseObj = RemoteData.NotAsked
    , route = route
    }

-- Decoders

decodeCase : Decode.Decoder Case
decodeCase =
    decode Case
        |> required "id" Decode.string
        |> required "title" Decode.string
        |> required "description" Decode.string


decodeCases : Decode.Decoder (List Case)
decodeCases =
    Decode.list decodeCase

type Route
    = CasesRoute
    | CaseRoute CaseId
    | NotFoundRoute