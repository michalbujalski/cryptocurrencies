module Msgs exposing (..)
import Models exposing (..)
import RemoteData exposing (WebData)
type Msg
  = UpdateCurrency (WebData Ticker)
  | SelectMarket Market