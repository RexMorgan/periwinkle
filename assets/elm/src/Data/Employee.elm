module Data.Employee
  exposing
    ( Employee
    , EmployeeId
    , decoder
    , queryDecoder
    , idParser
    , idToString )

import Json.Decode as Decode exposing (Decoder, nullable, string)
import Json.Decode.Pipeline exposing (custom, decode, hardcoded, required, optional)
import UrlParser

type alias Employee =
  { id : EmployeeId
  , title : String
  , firstName : String
  , lastName : String
  , fullName : String
  , jobTitle : String
  , status : String
  , phoneNumber : String
  , emailAddress : String
  , timeZone : String
  }

type EmployeeId
  = EmployeeId String

idParser : UrlParser.Parser (EmployeeId -> a) a
idParser =
  UrlParser.custom "EMPLOYEEID" (Ok << EmployeeId)

idToString : EmployeeId -> String
idToString (EmployeeId employeeId) =
  employeeId

queryDecoder : Decoder (List Employee)
queryDecoder =
  Decode.at ["data"] listDecoder

listDecoder : Decoder (List Employee)
listDecoder =
  Decode.at ["employees"] (Decode.list decoder)

decoder : Decoder Employee
decoder =
  decode Employee
    |> required "id" (Decode.map EmployeeId string)
    |> optional "title" string ""
    |> optional "firstName" string ""
    |> optional "lastName" string ""
    |> optional "fullName" string ""
    |> optional "jobTitle" string ""
    |> optional "status" string ""
    |> optional "phoneNumber" string ""
    |> optional "emailAddress" string ""
    |> optional "timeZone" string ""