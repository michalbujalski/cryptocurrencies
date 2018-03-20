module Updates exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Market, Ticker)
import CurrenciesSelect.Models exposing (..)
import RemoteData exposing (..)
import CurrenciesSelect.Updates exposing (..)
import Commands exposing (fetchCurrency, currencyUrl)
import Navigation exposing (newUrl)
import Routing exposing (..)

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
      Msgs.UpdateCurrency ticker ->
        let
            newSelected = updateSelectedMarket ticker
        in
          ( { model | ticker = ticker, selectedMarket = newSelected }, Cmd.none )
      Msgs.SelectMarket selectedMarket ->
        ( { model | selectedMarket = Just selectedMarket }, Cmd.none )
      Msgs.ChangeLocation cryptoCurrency currency ->
        let
            currenciesSelect = model.currenciesSelect
            newCurrenciesSelect = { currenciesSelect 
              | showCryptoCurrenciesSelectMenu = False
              , showCurrenciesSelectMenu = False
              , currentCryptoCurrency = cryptoCurrency
              , currentCurrency = currency
              }
        in
            ({ model
            | currenciesSelect = newCurrenciesSelect
            , changes = model.changes + 1 }, Cmd.batch[ newUrl <| parseTickerUrl cryptoCurrency currency])
      Msgs.OnLocationChange location ->
        let
            currenciesSelect = model.currenciesSelect
            newRoute =
              parseLocation location
            tickerPath = case parseTickerPath location of
              Just tickerPath -> tickerPath
              Nothing -> { currency = defaultCurrency.symbol, cryptoCurrency = defaultCryptoCurrency.symbol }
            newCurrenciesSelect = updateSelectedCurrenciesWithMaybe
              model.currenciesSelect
              (getCurrency tickerPath.cryptoCurrency model.currenciesSelect.cryptoCurrencies)
              (getCurrency tickerPath.currency model.currenciesSelect.currencies)
        in
          ( { model
            | route = newRoute 
            , currenciesSelect = newCurrenciesSelect
            }, fetchCurrency <| currencyUrl tickerPath.cryptoCurrency tickerPath.currency)

updateSelectedCurrencies : CurrenciesSelectModel -> CryptoCurrency -> Currency -> CurrenciesSelectModel
updateSelectedCurrencies model crypto currency =
  { model | currentCryptoCurrency = crypto, currentCurrency = currency }

updateSelectedCurrenciesWithMaybe : CurrenciesSelectModel -> Maybe CryptoCurrency -> Maybe Currency -> CurrenciesSelectModel
updateSelectedCurrenciesWithMaybe model maybeCrypto maybeCurrency =
  let
      newCrypto = case maybeCrypto of
          Just crypto -> crypto      
          Nothing -> model.currentCryptoCurrency
      newCurrency = case maybeCurrency of
          Just currency -> currency
          Nothing -> model.currentCurrency
  in
    updateSelectedCurrencies model newCrypto newCurrency
      

getCurrency : String -> Currencies -> Maybe Currency
getCurrency code currencies =
  List.head <| List.filter (\x -> x.symbol == code) currencies

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