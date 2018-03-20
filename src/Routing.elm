module Routing exposing (..)
import UrlParser exposing (oneOf, (</>), s, Parser, map, top, string, parsePath)
import Navigation exposing (..)

type alias TickerPath =
  { cryptoCurrency : String
  , currency : String
  }
type Route = HomeRoute | TickerRoute String String | NotFoundRoute

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