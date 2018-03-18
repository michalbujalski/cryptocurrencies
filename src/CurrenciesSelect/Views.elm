module CurrenciesSelect.Views exposing (..)

import Html exposing (div, Html, a, text, button, span, i)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id, class, classList)
import Html.Attributes.Aria exposing (role, ariaHasPopup, ariaControls, ariaHidden)
import CurrenciesSelect.Models exposing (CurrenciesSelectModel, Currency)
import CurrenciesSelect.Msgs exposing (..)
import Msgs exposing (Msg)

currenciesSelectView : CurrenciesSelectModel -> Html Msg
currenciesSelectView model =
  div [ class "dropdown currency-select__container", classList [("is-active", model.isOpened)] ]
    [ div [ class "dropdown-trigger" ]
    [ button 
      [ class "button"
      , ariaHasPopup "true"
      , ariaControls "dropdown-menu"
      , onClick <| Msgs.CurrencySelect ToggleCryptoCurrenciesMenu
      ]
      [ span [] [text "currency"]
      , span [ class "icon is-small" ]
        [ i [ class "fas fa-angle-down", ariaHidden True ] [] ]
      ]
    ]
    , div [ class "dropdown-menu", role "menu", id "dropdown-menu" ]
      [ div [ class "dropdown-content" ]
        ( List.map menuItemView model.cryptoCurrencies )
      ]
  ]

menuItemView : Currency -> Html Msg
menuItemView currency =
  a [ class "dropdown-item currency-select__item", onClick <| Msgs.FetchTicker currency.symbol] [ text <| currency.symbol ++ " - " ++ currency.name]