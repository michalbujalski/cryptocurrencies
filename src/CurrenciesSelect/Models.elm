module CurrenciesSelect.Models exposing (..)

type alias CurrenciesSelectModel =
  { showCryptoCurrenciesSelectMenu : Bool
  , showCurrenciesSelectMenu : Bool
  , cryptoCurrencies : CryptoCurrencies
  , currentCryptoCurrency: CryptoCurrency
  , currencies : Currencies
  , currentCurrency : Currency
  }

type alias Currencies = List Currency
type alias Currency =
  { name : String
  , symbol : String
  }
type alias CryptoCurrency = Currency
type alias CryptoCurrencies = Currencies

cryptoCurrencies : CryptoCurrencies
cryptoCurrencies =
  [ defaultCryptoCurrency
  , { name = "Ether", symbol = "ETH" }
  , { name = "Litecoin", symbol = "LTC" }
  , { name = "Ripple", symbol = "XRP" }
  , { name = "Bitcoin Cash", symbol = "BCH"}
  , { name = "Monero", symbol = "XMR"}
  , { name = "Bitcoin Gold", symbol = "BTG"}
  ]

currencies : Currencies
currencies = 
  [ defaultCurrency
  , { name = "Euro", symbol = "EUR" }
  , { name = "British Pound", symbol = "GBP" }
  , { name = "Yen", symbol = "JPY" }
  ]

defaultCurrency : Currency
defaultCurrency = 
  { name = "US Dollar", symbol = "USD" }

defaultCryptoCurrency : CryptoCurrency
defaultCryptoCurrency = 
  { name = "Bitcoin", symbol = "BTC" }

initCurrenciesSelectModel : CurrenciesSelectModel
initCurrenciesSelectModel = 
  { showCryptoCurrenciesSelectMenu = False
  , showCurrenciesSelectMenu = False
  , cryptoCurrencies = cryptoCurrencies
  , currentCryptoCurrency = defaultCryptoCurrency
  , currencies = currencies
  , currentCurrency = defaultCurrency
  }