module Updates exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model, Market, Currency)
import RemoteData exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      Msgs.UpdateCurrency currency ->
        let
            newSelected = updateSelectedMarket currency
        in
          ( { model | currency = currency, selectedMarket = newSelected }, Cmd.none )
      Msgs.SelectMarket selectedMarket ->
        ( { model | selectedMarket = Just selectedMarket }, Cmd.none )

updateSelectedMarket : WebData Currency -> Maybe Market
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