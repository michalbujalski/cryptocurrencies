module Main exposing (..)

import Html exposing (program)
import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import Commands exposing (..)
import Views exposing (view)


init : ( Model, Cmd Msg )
init =
    ( defaultModel, fetchCurrency currencyUrl)

main : Program Never Model Msg
main =
    program
      { view = view
      , init = init
      , update = Updates.update
      , subscriptions = always Sub.none
      }
