module Views exposing (..)

import Html exposing (Html, text, div, button, h1, img, button, li, ul, a, h2)
import Html.Attributes exposing (src, class, classList)
import Html.Events exposing (onClick)
import Models exposing (Model, Ticker, Market, CurrencySymbol)
import Msgs exposing (Msg)
import RemoteData exposing (..)
import CurrenciesSelect.Views exposing (..)
import CurrenciesSelect.Models exposing (..)

view : Model -> Html Msg
view model =
    currencyFetchView model

currencyFetchView : Model -> Html Msg
currencyFetchView model =
  case model.ticker of
      Loading ->
          div [] [ text "Loading..." ]
      NotAsked ->
          div [] []
      Failure failure ->
          div [] [ text <| toString failure ]
      Success payload ->
        case model.selectedMarket of
            Just selectedMarket ->
              currencyView payload selectedMarket model.currenciesSelect.currentCurrency.symbol model.currenciesSelect
            Nothing ->
              div [] []

currencyView : Ticker -> Market -> CurrencySymbol -> CurrenciesSelectModel -> Html Msg
currencyView ticker selectedMarket currencySymbol currenciesSelect =
  div []
    [ currenciesSelectView currenciesSelect
    , div [] [ text <| ticker.base ++ " - " ++ ticker.target ]
    , div [] [ text <| formattedCurrencyView currencySymbol ticker.price ]
    , div [] [ text <| formattedCurrencyView currencySymbol ticker.change ]
    , div [] [ text <| ticker.volume ]
    , marketTabsView ticker.markets selectedMarket
    , marketView selectedMarket currencySymbol
    ]

marketTabsView : List Market -> Market -> Html Msg
marketTabsView markets selectedMarket =
  div [ class "tabs market__tabs" ]
    [ ul [] 
      ( List.map2 marketTabView markets (List.repeat (List.length markets) selectedMarket)) ]

marketTabView : Market -> Market -> Html Msg
marketTabView market selectedMarket =
  li [ classList [ ( "is-active", market == selectedMarket ) ] ]
    [ a [ onClick <| Msgs.SelectMarket market ]
      [ text market.market ] ]

marketView : Market -> CurrencySymbol -> Html Msg
marketView market symbol =
  div []
    [ h2 [ class "market__name" ] [ text market.market ]
    , h2 [ class "market__price" ] [ text <| formattedCurrencyView symbol market.price ]
    , h2 [ class "market__volume" ] [ text <| toString market.volume ]
  ]

formattedCurrencyView : CurrencySymbol -> String -> String
formattedCurrencyView currency price =
  currency ++ " " ++ price