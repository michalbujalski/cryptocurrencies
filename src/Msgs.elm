module Msgs exposing (..)
import Models exposing (..)
import RemoteData exposing (WebData)
import CurrenciesSelect.Msgs exposing (CurrenciesSelectMsg)
import CurrenciesSelect.Models exposing (Currency)
import Navigation exposing (..)

type Msg
  = UpdateCurrency (WebData Ticker)
  | SelectMarket Market
  | FetchTickerWithUpdatedCryptoCurrency Currency
  | FetchTickerWithUpdatedCurrency Currency
  | CurrencySelect CurrenciesSelectMsg
  | OnLocationChange Navigation.Location