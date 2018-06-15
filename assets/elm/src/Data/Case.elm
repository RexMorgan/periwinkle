module Data.Case
  exposing
    ( Case
    , CaseId
    , decoder
    , listDecoder
    , queryDecoder
    , idParser
    , idToString
    , Body)

import Data.Employee as Employee exposing(Employee)
import Data.User as User exposing(User)
import Json.Decode as Decode exposing (Decoder, nullable, string, bool)
import Json.Decode.Pipeline exposing (custom, decode, hardcoded, required, optional)
import UrlParser

type alias Case =
  { id : CaseId
  , title : String
  , status : String
  , priority : String
  , severity : String
  , caseType : String
  , origin : String
  , availableInSelfService : Bool
  , isSensitive : Bool
  , employee : Maybe Employee
  , owner : Maybe User
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

queryDecoder : Decoder (List Case)
queryDecoder =
  Decode.at ["data"] listDecoder

listDecoder : Decoder (List Case)
listDecoder =
  Decode.at ["cases"] (Decode.list decoder)

decoder : Decoder Case
decoder =
  decode Case
    |> required "id" (Decode.map CaseId string)
    |> optional "title" string ""
    |> optional "status" string ""
    |> optional "priority" string ""
    |> optional "severity" string ""
    |> optional "caseType" string ""
    |> optional "origin" string ""
    |> optional "availableInSelfService" bool False
    |> optional "isSensitive" bool False
    |> optional "employee" (Decode.map Just Employee.decoder) Nothing
    |> optional "owner" (Decode.map Just User.decoder) Nothing