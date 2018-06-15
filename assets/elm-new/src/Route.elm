module Route exposing (Route(..), fromLocation, href, modifyUrl)

import Data.Case as Case
import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)

-- ROUTING --

type Route
  = Root
  | Dashboard

route : Parser (Route -> a) a
route =
  oneOf
    [ Url.map Dashboard (s "")
    ]

-- INTERNAL --

routeToString : Route -> String
routeToString page =
  let
    pieces =
      case page of
        Root ->
          []

        Dashboard ->
          []
  in
  "#/" ++ String.join "/" pieces

href : Route -> Attribute msg
href route =
  Attr.href (routeToString route)

modifyUrl : Route -> Cmd msg
modifyUrl =
  routeToString >> Navigation.modifyUrl

fromLocation : Location -> Maybe Route
fromLocation location =
  if String.isEmpty location.hash then
    Just Root
  else
    parseHash route location