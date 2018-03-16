module Commands exposing (..)
import Models exposing (..)
import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData exposing (..)
import Msgs exposing (..)

currencyUrl : String
currencyUrl = "https://api.cryptonator.com/api/full/btc-usd"

fetchCurrency : String -> Cmd Msg
fetchCurrency url =
  Http.get url tickerDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.UpdateCurrency

type alias Ticker = {
  ticker: Currency
}

tickerDecoder : Decode.Decoder Currency
tickerDecoder =
  Decode.at ["ticker"] currencyDecoder

marketDecoder : Decode.Decoder Market
marketDecoder =
  decode Market
    |> required "market" Decode.string
    |> required "price" Decode.string
    |> required "volume" Decode.float
 
marketsDecoder : Decode.Decoder (List Market)
marketsDecoder =
  Decode.list marketDecoder

currencyDecoder : Decode.Decoder Currency
currencyDecoder =
  decode Currency
    |> required "base" Decode.string
    |> required "target" Decode.string
    |> required "price" Decode.string
    |> required "volume" Decode.string
    |> required "change" Decode.string
    |> required "markets" marketsDecoder