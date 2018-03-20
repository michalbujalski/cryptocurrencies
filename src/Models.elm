module Models exposing (..)
import CurrenciesSelect.Models exposing (..)
import RemoteData exposing (..)
import Routing exposing (..)
type alias Market =
  { market: String
  , price: String
  , volume: Float
  }

type alias Ticker =
  { base: String
  , target: String
  , price: String
  , volume: String
  , change: String
  , markets: List Market
  }

type alias SelectedMarket = Maybe Market

type alias Model =
  { ticker: WebData Ticker
  , selectedMarket: SelectedMarket
  , currencySymbol: CurrencySymbol
  , currentCryptoCurrency: Currency
  , cryptoCurrencies: Currencies
  , currenciesSelect: CurrenciesSelectModel
  , route: Route
  }

type alias CurrencySymbol = String

defaultModel : Route -> Model
defaultModel route = 
  { ticker = RemoteData.Loading
  , selectedMarket = Nothing
  , currencySymbol = "$"
  , currentCryptoCurrency = defaultCryptoCurrency
  , cryptoCurrencies = cryptoCurrencies
  , currenciesSelect = initCurrenciesSelectModel
  , route = route
  }
