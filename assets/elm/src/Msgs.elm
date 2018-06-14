module Msgs exposing (..)

import Http
import Models exposing (..)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchCases (WebData (List Case))
    | OnLocationChange Location
    | OnFetchCase (WebData Case)
    | GetCase String