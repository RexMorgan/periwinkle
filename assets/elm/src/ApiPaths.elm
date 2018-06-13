module ApiPaths exposing (..)

-- Paths to API Endpoints

baseApiHost: String
baseApiHost =
    "http://localhost:4000"

apiCaseList : String
apiCaseList =
    baseApiHost ++ "/api/cases"

apiCase : String -> String
apiCase id =
    baseApiHost ++ "/api/case/" ++ (id)