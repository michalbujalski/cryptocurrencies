module CurrenciesSelect.Views exposing (..)

import Html exposing (div, Html, a, text, button, span, i)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id, class, classList)
import Html.Attributes.Aria exposing (role, ariaHasPopup, ariaControls, ariaHidden)
import CurrenciesSelect.Models exposing (CurrenciesSelectModel, Currency, Currencies)
import CurrenciesSelect.Msgs exposing (..)
import Msgs exposing (Msg)

currenciesSelectView : CurrenciesSelectModel -> Html Msg
currenciesSelectView model =
  div []
    [ dropDownView
        model.currentCryptoCurrency
        (Msgs.CurrencySelect ToggleCryptoCurrenciesMenu)
        model.cryptoCurrencies
        model.showCryptoCurrenciesSelectMenu
        Msgs.FetchTickerWithUpdatedCryptoCurrency
    , dropDownView
        model.currentCurrency
        (Msgs.CurrencySelect ToggleCurrenciesMenu)
        model.currencies
        model.showCurrenciesSelectMenu 
        Msgs.FetchTickerWithUpdatedCurrency
    ]

dropDownView : Currency -> Msg -> Currencies -> Bool -> (Currency -> Msg) -> Html Msg
dropDownView selectedCurrency msg currencies isOpened itemMsg =
    div [ class "dropdown currency-select__container", classList [("is-active", isOpened)] ]
    [ div [ class "dropdown-trigger" ]
      [ dropdownButtonView 
        ( selectedCurrency.symbol ++ " - " ++ selectedCurrency.name ) msg
      , div [ class "dropdown-menu", role "menu", id "dropdown-menu" ]
        [ div [ class "dropdown-content" ] 
          ( List.map2
            menuItemView 
            currencies
            ( List.repeat (List.length currencies) itemMsg )
          )
        ]
      ]
    ]

dropdownButtonView : String -> Msg -> Html Msg
dropdownButtonView caption msg =
  button 
      [ class "button currency-select__button"
      , ariaHasPopup "true"
      , ariaControls "dropdown-menu"
      , onClick msg
      ]
      [ span [] [ text caption ]
      , span [ class "icon is-small" ]
        [ i [ class "fas fa-angle-down", ariaHidden True ] [] ]
      ]

menuItemView : Currency -> (Currency -> Msg) -> Html Msg
menuItemView currency msg =
  a [ class "dropdown-item currency-select__item", onClick <| msg currency ]
    [ text <| currency.symbol ++ " - " ++ currency.name ]