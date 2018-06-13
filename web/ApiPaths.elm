module ApiPaths exposing (..)

-- Paths to API Endpoints

-- baseApiHost?

apiCaseList : String
apiCaseList =
    "/api/caselist"

apiCase : String -> String
apiCase id =
    "/api/case/" ++ (id)