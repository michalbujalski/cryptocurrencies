module Routing exposing (..)
import UrlParser exposing (oneOf, (</>), s, Parser, map, top, string, parsePath)
import Navigation exposing (..)
import Models exposing (..)
import CurrenciesSelect.Models exposing (..)

matchers : Parser (Route -> a) a
matchers =
  oneOf
    [ map HomeRoute top
    , map TickerRoute (s "ticker" </> string </> string )
    ]
  
parseLocation : Navigation.Location -> Route
parseLocation location =
  case parsePath matchers location of
    Just route ->
      route
    Nothing ->
      NotFoundRoute

parseTickerPath : Navigation.Location -> Maybe TickerPath
parseTickerPath location = 
  parsePath ( map TickerPath <| s "ticker" </> string </> string ) location
  |> formatSybols

formatSybols : Maybe TickerPath -> Maybe TickerPath
formatSybols maybeTickerPath =
  case maybeTickerPath of
    Just tickerPath ->
      let
          newCryptoCurrency = String.toUpper tickerPath.cryptoCurrency
          newCurrency = String.toUpper tickerPath.currency
      in
        Just { tickerPath | cryptoCurrency = newCryptoCurrency, currency = newCurrency }
    Nothing -> Nothing

parseTickerUrl : CryptoCurrency -> Currency -> String
parseTickerUrl cryptoCurrency currency =
  "/ticker/" ++ ( String.toUpper cryptoCurrency.symbol ) ++ "/" ++ (String.toUpper currency.symbol)