module Models exposing (..)

import RemoteData exposing (..)

type alias Market = {
  market: String,
  price: String,
  volume: Float
}

type alias Currency = {
  base: String,
  target: String,
  price: String,
  volume: String,
  change: String,
  markets: List Market
}

type alias Model = {
  currency: WebData Currency
}

defaultModel : Model
defaultModel = 
  { currency = RemoteData.Loading
  }
