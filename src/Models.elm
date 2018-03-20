module Models exposing (..)
import CurrenciesSelect.Models exposing (..)
import RemoteData exposing (..)

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

type Route = HomeRoute | TickerRoute String String | NotFoundRoute
type alias SelectedMarket = Maybe Market

type alias Model =
  { ticker: WebData Ticker
  , selectedMarket: SelectedMarket
  , currentCryptoCurrency: Currency
  , cryptoCurrencies: Currencies
  , currenciesSelect: CurrenciesSelectModel
  , route: Route
  , changes: Int
  }

type alias TickerPath =
  { cryptoCurrency : String
  , currency : String
  }

defaultModel : Route -> Model
defaultModel route = 
  { ticker = RemoteData.Loading
  , selectedMarket = Nothing
  , currentCryptoCurrency = defaultCryptoCurrency
  , cryptoCurrencies = cryptoCurrencies
  , currenciesSelect = initCurrenciesSelectModel
  , route = route
  , changes = 0
  }
