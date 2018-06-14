module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (CaseId, Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map CasesRoute top
        , map CaseRoute (s "cases" </> string)
        , map CasesRoute (s "cases")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


casesPath : String
casesPath =
    "#/cases"


casePath : CaseId -> String
casePath id =
    "#/cases/" ++ id