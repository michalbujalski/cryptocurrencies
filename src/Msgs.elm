module Msgs exposing (..)
import Models exposing (..)
import RemoteData exposing (WebData)
import CurrenciesSelect.Msgs exposing (CurrenciesSelectMsg)

type Msg
  = UpdateCurrency (WebData Ticker)
  | SelectMarket Market
  | FetchTicker String
  | CurrencySelect CurrenciesSelectMsg