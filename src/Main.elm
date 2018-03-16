module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import RemoteData exposing (..)
import Commands exposing (..)
---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( defaultModel, fetchCurrency currencyUrl)

---- VIEW ----


view : Model -> Html Msg
view model =
    currencyFetchView model

currencyFetchView : Model -> Html Msg
currencyFetchView model =
  case model.currency of
      Loading ->
          div [] [ text "Loading..." ]
      NotAsked ->
          div [] []
      Failure failure ->
          div [] [ text <| toString failure ]
      Success payload ->
          currencyView payload

currencyView : Currency -> Html Msg
currencyView currency =
  div []
    [ div [] [ text <| currency.base ++ " - " ++ currency.target ]
    , div [] [ text <| "$ " ++ currency.price ]
    ]

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = Updates.update
        , subscriptions = always Sub.none
        }
