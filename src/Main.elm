module Main exposing (..)

import Html exposing (program)
import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import Views exposing (view)
import Commands exposing (fetchCurrency, currencyUrl)


init : ( Model, Cmd Msg )
init =
    ( defaultModel, fetchCurrency <| currencyUrl "btc" "usd")

main : Program Never Model Msg
main =
    program
      { view = view
      , init = init
      , update = Updates.update
      , subscriptions = always Sub.none
      }
