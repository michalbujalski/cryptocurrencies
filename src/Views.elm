module Views exposing (..)

import Html exposing (Html, text, div, button, h1, img, button)
import Html.Attributes exposing (src, class)
import Models exposing (Model, Currency)
import Msgs exposing (Msg)
import RemoteData exposing (..)

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
    , button [ class "button is-primary" ] [ text "test" ]
    ]