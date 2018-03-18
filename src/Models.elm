module Models exposing (..)

import RemoteData exposing (..)

type alias Market = {
  market: String,
  price: String,
  volume: Float
}

type alias Ticker = {
  base: String,
  target: String,
  price: String,
  volume: String,
  change: String,
  markets: List Market
}

type alias SelectedMarket = Maybe Market

type alias Model =
  { ticker: WebData Ticker
  , selectedMarket: SelectedMarket
  , currencySymbol: CurrencySymbol
}

type alias CurrencySymbol = String

defaultModel : Model
defaultModel = 
  { ticker = RemoteData.Loading
  , selectedMarket = Nothing
  , currencySymbol = "$"
  }
