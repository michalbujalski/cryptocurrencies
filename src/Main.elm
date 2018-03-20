module Main exposing (..)

import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import Views exposing (view)
import Routing exposing (..)
import Navigation exposing (Location)
import Routing exposing (..)
import Updates exposing (..)

init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute =
      Routing.parseLocation location
    tickerPath = case parseTickerPath location of
            Just tickerPath -> tickerPath
            Nothing -> { currency = "USD", cryptoCurrency = "BTC" }
  in
    update (Msgs.OnLocationChange location) (defaultModel currentRoute)

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
      { view = view
      , init = init
      , update = Updates.update
      , subscriptions = always Sub.none
      }
