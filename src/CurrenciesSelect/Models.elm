module CurrenciesSelect.Models exposing (..)

type alias CurrenciesSelectModel =
  { isOpened : Bool
  , cryptoCurrencies : Currencies
  }

type alias Currencies = List Currency
type alias Currency =
  { name : String
  , symbol : String
  }

cryptoCurrencies : Currencies
cryptoCurrencies =
  [ defaultCryptoCurrency
  , { name = "Ether", symbol = "ETH" }
  , { name = "Litecoin", symbol = "LTC" }
  , { name = "Ripple", symbol = "XRP" }
  , { name = "Bitcoin Cash", symbol = "BCH"}
  , { name = "Monero", symbol = "XMR"}
  , { name = "Bitcoin Gold", symbol = "BTG"}
  ]

defaultCryptoCurrency : Currency
defaultCryptoCurrency = 
  { name = "Bitcoin", symbol = "BTC" }

initCurrenciesSelectModel : CurrenciesSelectModel
initCurrenciesSelectModel = 
  { isOpened = False
  , cryptoCurrencies = cryptoCurrencies
  }