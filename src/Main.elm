module Main exposing (..)

import Html exposing (program)
import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import Views exposing (view)
import Commands exposing (fetchCurrency, currencyUrl)
import Routing exposing (..)
import Navigation exposing (Location)
import Routing exposing (..)

init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute =
      Routing.parseLocation location
    tickerPath = case parseTickerPath location of
            Just tickerPath -> tickerPath
            Nothing -> { currency = "USD", cryptoCurrency = "BTC" }
  in
    ( defaultModel currentRoute, fetchCurrency <| currencyUrl tickerPath.cryptoCurrency tickerPath.currency)

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
      { view = view
      , init = init
      , update = Updates.update
      , subscriptions = always Sub.none
      }
