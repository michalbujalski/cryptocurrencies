module Updates exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Market, Ticker)
import RemoteData exposing (..)
import CurrenciesSelect.Updates exposing (..)
import Commands exposing (fetchCurrency, currencyUrl)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      Msgs.CurrencySelect msg ->
        let
            ( updatedCurrenciesSelect, cmd) = updateCurrencies model.currenciesSelect msg
        in
            ( { model
              | currenciesSelect = updatedCurrenciesSelect }
              , Cmd.map Msgs.CurrencySelect cmd)
      Msgs.FetchTickerWithUpdatedCurrency currency ->
        let
            currentCurrency = model.currenciesSelect
            cryptoSymbol = currentCurrency.currentCryptoCurrency.symbol
            newCurrenciesSelect = { currentCurrency 
              | showCurrenciesSelectMenu = False
              , currentCurrency = currency 
              , showCurrenciesSelectMenu = False
              }
        in
          ( { model 
            | currenciesSelect = newCurrenciesSelect 
            , ticker = RemoteData.Loading }
            , fetchCurrency <| currencyUrl cryptoSymbol currency.symbol )
      Msgs.FetchTickerWithUpdatedCryptoCurrency currency ->
        let
            currenciesSelect = model.currenciesSelect
            currencySymbol = currenciesSelect.currentCurrency.symbol
            newCurrenciesSelect = { currenciesSelect 
              | showCryptoCurrenciesSelectMenu = False
              , currentCryptoCurrency = currency 
              , showCurrenciesSelectMenu = False
              }
        in
          ( { model
            | currenciesSelect = newCurrenciesSelect
            , ticker = RemoteData.Loading }
            , fetchCurrency <| currencyUrl currency.symbol currencySymbol)
      Msgs.UpdateCurrency ticker ->
        let
            newSelected = updateSelectedMarket ticker
        in
          ( { model | ticker = ticker, selectedMarket = newSelected }, Cmd.none )
      Msgs.SelectMarket selectedMarket ->
        ( { model | selectedMarket = Just selectedMarket }, Cmd.none )

updateSelectedMarket : WebData Ticker -> Maybe Market
updateSelectedMarket data =
  case data of
      Loading -> 
        Nothing
      NotAsked ->
        Nothing
      Failure failure ->
        Nothing 
      Success payload -> selectMarket payload.markets         

selectMarket : List Market -> Maybe Market
selectMarket markets =
  case (List.head markets) of
      Just market ->
        Just market
      Nothing -> Nothing