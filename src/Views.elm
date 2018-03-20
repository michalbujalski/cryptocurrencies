module Views exposing (..)

import Html exposing (Html, text, div, button, h1, img, button, li, ul, a, h2, span)
import Html.Attributes exposing (src, class, classList)
import Html.Events exposing (onClick)
import Models exposing (Model, Ticker, Market)
import Msgs exposing (Msg)
import RemoteData exposing (..)
import CurrenciesSelect.Views exposing (..)
import CurrenciesSelect.Models exposing (..)

view : Model -> Html Msg
view model =
    currencyFetchView model

currencyFetchView : Model -> Html Msg
currencyFetchView model =
  div [] 
    [ currenciesSelectView model.currenciesSelect
    , case model.ticker of
        Loading ->
            div [] [ text "Loading..." ]
        NotAsked ->
            div [] []
        Failure failure ->
            div [] [ text <| toString failure ]
        Success payload ->
            currencyView payload model.selectedMarket model.currenciesSelect.currentCurrency.symbol model.currenciesSelect

    ]

currencyView : Ticker -> Maybe Market -> String -> CurrenciesSelectModel -> Html Msg
currencyView ticker selectedMarket currencySymbol currenciesSelect =
  div []
    [ div [ class "ticker__container" ]
      [ valueView "Exchange rate : " <| ticker.base ++ " - " ++ ticker.target
      , valueView "Price : " <| formattedCurrencyView currencySymbol ticker.price
      , valueView "Change : " <| formattedCurrencyView currencySymbol ticker.change
      , valueView "Volume : " <| ticker.volume
      ]
    , marketTabsView ticker.markets selectedMarket
    , marketView selectedMarket currencySymbol
    ]

valueView : String -> String -> Html Msg
valueView label value =
  div []
    [ span [ class "ticker-field__label" ] [ text label ]
    , span [ class "ticker-field__value" ] [ text value ]
    ]

marketTabsView : List Market -> Maybe Market -> Html Msg
marketTabsView markets selectedMarketMaybe =
  case selectedMarketMaybe of
      Just selectedMarket ->
        div [ class "tabs market__tabs" ]
          [ ul [] 
            ( List.map2 marketTabView markets (List.repeat (List.length markets) selectedMarket)) ]
      Nothing ->
        div [][]

marketTabView : Market -> Market -> Html Msg
marketTabView market selectedMarket =
  li [ classList [ ( "is-active", market == selectedMarket ) ] ]
    [ a [ onClick <| Msgs.SelectMarket market ]
      [ text market.market ] ]

marketView : Maybe Market -> String -> Html Msg
marketView maybeMarket symbol =
  case maybeMarket of
      Just market ->
        div [ class "market__container"]
          [ valueView "Price : " <| formattedCurrencyView symbol market.price
          , valueView "Woluem : " <| toString market.volume
          ]
      Nothing ->
        div [ class "market__empty" ]
          [ text "No markets" ]


formattedCurrencyView : String -> String -> String
formattedCurrencyView currency price =
  currency ++ " " ++ price