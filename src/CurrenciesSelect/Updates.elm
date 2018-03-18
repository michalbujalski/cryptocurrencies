module CurrenciesSelect.Updates exposing (..)
import CurrenciesSelect.Msgs exposing (CurrenciesSelectMsg)
import CurrenciesSelect.Models exposing (..)

updateCurrencies : CurrenciesSelectModel -> CurrenciesSelectMsg -> ( CurrenciesSelectModel, Cmd msg )
updateCurrencies model msg =
  case msg of
      CurrenciesSelect.Msgs.ToggleCryptoCurrenciesMenu ->
        let
            newIsOpened = not model.isOpened
        in
          ( { model | isOpened = newIsOpened } , Cmd.none )