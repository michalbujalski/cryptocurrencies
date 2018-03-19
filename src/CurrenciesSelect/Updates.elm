module CurrenciesSelect.Updates exposing (..)
import CurrenciesSelect.Msgs exposing (CurrenciesSelectMsg)
import CurrenciesSelect.Models exposing (..)

updateCurrencies : CurrenciesSelectModel -> CurrenciesSelectMsg -> ( CurrenciesSelectModel, Cmd msg )
updateCurrencies model msg =
  case msg of
      CurrenciesSelect.Msgs.ToggleCryptoCurrenciesMenu ->
        let
            newIsOpened = not model.showCryptoCurrenciesSelectMenu
        in
          ( { model | showCryptoCurrenciesSelectMenu = newIsOpened } , Cmd.none )
      CurrenciesSelect.Msgs.ToggleCurrenciesMenu ->
        let
          newIsOpened = not model.showCurrenciesSelectMenu
        in
          ( { model | showCurrenciesSelectMenu = newIsOpened } , Cmd.none )