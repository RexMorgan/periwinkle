module Request.Helpers exposing (apiUrl, graphUrl)


apiUrl : String -> String
apiUrl str =
  "http://localhost:4000/api" ++ str

graphUrl : String
graphUrl =
  "http://localhost:4000/graphql"