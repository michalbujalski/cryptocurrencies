module CurrenciesSelect.Views exposing (..)

import Html exposing (div, Html, a, text, button, span, i, Attribute)
import Json.Decode as Decode
import Html.Events exposing (onClick, onWithOptions)
import Html.Attributes exposing (id, class, classList, href)
import Html.Attributes.Aria exposing (role, ariaHasPopup, ariaControls, ariaHidden)
import CurrenciesSelect.Models exposing (CurrenciesSelectModel, Currency, Currencies)
import CurrenciesSelect.Msgs exposing (..)
import Msgs exposing (Msg)
import Routing exposing (parseTickerUrl)


-- ( List.repeat (List.length currencies) currency )

createCurrenciesLists : Currency -> Int -> Currencies
createCurrenciesLists currency len =
  ( List.repeat len currency )

currenciesSelectView : CurrenciesSelectModel -> Html Msg
currenciesSelectView model =
  div []
    [ dropDownView
        model.cryptoCurrencies
        model.currentCryptoCurrency
        model.cryptoCurrencies
        (Msgs.CurrencySelect ToggleCryptoCurrenciesMenu)
        (createCurrenciesLists model.currentCurrency <| List.length model.currencies)
        model.showCryptoCurrenciesSelectMenu
    , dropDownView
        model.currencies
        model.currentCurrency
        (createCurrenciesLists model.currentCryptoCurrency <| List.length model.cryptoCurrencies)
        (Msgs.CurrencySelect ToggleCurrenciesMenu)
        model.currencies
        model.showCurrenciesSelectMenu
    ]

dropDownView : Currencies -> Currency -> Currencies -> Msg -> Currencies -> Bool -> Html Msg
dropDownView displayableCurrencies selectedCurrency cryptoCurrencies msg currencies isOpened =
    div [ class "dropdown currency-select__container", classList [("is-active", isOpened)] ]
    [ div [ class "dropdown-trigger" ]
      [ dropdownButtonView 
        ( selectedCurrency.symbol ++ " - " ++ selectedCurrency.name ) msg
      , div [ class "dropdown-menu", role "menu", id "dropdown-menu" ]
        [ div [ class "dropdown-content" ] 
          ( List.map3
            menuItemView
            cryptoCurrencies
            currencies
            displayableCurrencies
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

menuItemView : Currency -> Currency -> Currency -> Html Msg
menuItemView cryptoCurrency currency displayCurrency =
  let
    path = parseTickerUrl cryptoCurrency currency
  in
    a [ class "dropdown-item currency-select__item", href path ,onLinkClick ( Msgs.ChangeLocation cryptoCurrency currency ) ]
      [ text <| displayCurrency.symbol ++ " - " ++ displayCurrency.name ]

onLinkClick : msg -> Attribute msg
onLinkClick message =
  let
    options =
      { stopPropagation = False
      , preventDefault = True
      }
  in
    onWithOptions "click" options (Decode.succeed message)