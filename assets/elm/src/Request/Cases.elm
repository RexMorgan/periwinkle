module Request.Cases exposing ( list, get, updateCase )

import Data.Case as Case exposing (Case, idToString, CaseId)
import Http
import HttpBuilder exposing (RequestBuilder, withBody, withExpect, withQueryParams)
import Json.Encode as Encode
import String.Interpolate exposing (interpolate)
import Request.Helpers exposing (apiUrl, graphUrl)
import Util exposing ((=>))

-- The Case --
get : Case.CaseId -> Http.Request Case
get slug =
    let
        expect =
            Case.decoder
                |> Http.expectJson
    in
    apiUrl ("/case/" ++ Case.idToString slug)
        |> HttpBuilder.get
        |> HttpBuilder.withExpect expect
        |> HttpBuilder.toRequest
-- LIST --

list : Http.Request (List Case)
list =
    [ ( "query"
      , """
        {
            cases {
                id,
                title,
                status,
                employee {
                    id,
                    avatar,
                    fullName
                },
                owner {
                    id,
                    avatar,
                    fullName
                }
            }
        }
        """
        |> Encode.string)]
        |> buildGraphQuery
        |> HttpBuilder.toRequest

updateCase : CaseId -> Case -> (Http.Request Case)
updateCase id theCase =
    [ ( "query"
      , interpolate """
        mutation {
            updateCase(id:"{0}",title:"{1}") {
                id
            }
        }
        """
        [ Case.idToString id
        , theCase.title]
        |> Encode.string
      )
    ]
        |> buildGraphMutation "updateCase"
        |> HttpBuilder.toRequest

-- HELPERS --

maybeVal : ( a, Maybe b ) -> Maybe ( a, b )
maybeVal ( key, value ) =
    case value of
        Nothing ->
            Nothing

        Just val ->
            Just (key => val)


buildFromQueryParams : String -> List ( String, String ) -> RequestBuilder (List Case)
buildFromQueryParams url queryParams =
    url
        |> apiUrl
        |> HttpBuilder.get
        |> withExpect (Http.expectJson Case.listDecoder)
        |> withQueryParams queryParams

buildGraphMutation : String -> List ( String, Encode.Value ) -> RequestBuilder Case
buildGraphMutation mutationName query =
    let
        body =
            query
            |> Encode.object
            |> Http.jsonBody
    in
        graphUrl
            |> HttpBuilder.post
            |> withExpect (Http.expectJson (Case.mutationDecoder mutationName))
            |> withBody body

buildGraphQuery : List (String, Encode.Value) -> RequestBuilder (List Case)
buildGraphQuery query =
    let
        body =
            query
            |> Encode.object
            |> Http.jsonBody
    in
    graphUrl
        |> HttpBuilder.post
        |> withExpect (Http.expectJson Case.queryDecoder)
        |> withBody body