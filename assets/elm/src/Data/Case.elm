module Data.Case
  exposing
    ( Case
    , CaseId
    , decoder
    , listDecoder
    , idParser
    , idToString
    , Body)

import Html exposing (Attribute, Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra
import Json.Decode.Pipeline exposing (custom, decode, hardcoded, required)
import UrlParser

type alias Case =
  { id : CaseId
  , title : String
  , status : String
  }

type Body
    = Body Markdown

type alias Markdown =
    String

type CaseId
  = CaseId String

idParser : UrlParser.Parser (CaseId -> a) a
idParser =
  UrlParser.custom "CASEID" (Ok << CaseId)

idToString : CaseId -> String
idToString (CaseId caseId) =
  caseId

listDecoder : Decoder (List Case)
listDecoder =
  Decode.at ["cases"] (Decode.list decoder)

decoder : Decoder Case
decoder =
  decode Case
    |> required "id" (Decode.map CaseId Decode.string)
    |> required "title" (Decode.map (Maybe.withDefault "") (Decode.nullable Decode.string))
    |> required "status" (Decode.map (Maybe.withDefault "") (Decode.nullable Decode.string))