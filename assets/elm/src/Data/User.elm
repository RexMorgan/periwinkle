module Data.User
  exposing
    ( User
    , UserId
    , decoder
    , queryDecoder
    , idParser
    , idToString )

import Json.Decode as Decode exposing (Decoder, nullable, string)
import Json.Decode.Pipeline exposing (custom, decode, hardcoded, required, optional)
import UrlParser

type alias User =
  { id : UserId
  , firstName : String
  , lastName : String
  , fullName : String
  , status : String
  , phoneNumber : String
  , emailAddress : String
  , timeZone : String
  , workgroup : String
  , department : String
  }

type UserId
  = UserId String

idParser : UrlParser.Parser (UserId -> a) a
idParser =
  UrlParser.custom "USERID" (Ok << UserId)

idToString : UserId -> String
idToString (UserId userId) =
  userId

queryDecoder : Decoder (List User)
queryDecoder =
  Decode.at ["data"] listDecoder

listDecoder : Decoder (List User)
listDecoder =
  Decode.at ["users"] (Decode.list decoder)

decoder : Decoder User
decoder =
  decode User
    |> required "id" (Decode.map UserId string)
    |> optional "firstName" string ""
    |> optional "lastName" string ""
    |> optional "fullName" string ""
    |> optional "status" string ""
    |> optional "phoneNumber" string ""
    |> optional "emailAddress" string ""
    |> optional "timeZone" string ""
    |> optional "workgroup" string ""
    |> optional "department" string ""