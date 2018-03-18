module Views exposing (..)

import Html exposing (Html, text, div, button, h1, img, button, li, ul, a, h2)
import Html.Attributes exposing (src, class, classList)
import Html.Events exposing (onClick)
import Models exposing (Model, Currency, Market)
import Msgs exposing (Msg)
import RemoteData exposing (..)

view : Model -> Html Msg
view model =
    currencyFetchView model

currencyFetchView : Model -> Html Msg
currencyFetchView model =
  case model.currency of
      Loading ->
          div [] [ text "Loading..." ]
      NotAsked ->
          div [] []
      Failure failure ->
          div [] [ text <| toString failure ]
      Success payload ->
        case model.selectedMarket of
            Just selectedMarket ->
              currencyView payload selectedMarket
            Nothing ->
              div [] []

currencyView : Currency -> Market -> Html Msg
currencyView currency selectedMarket =
  div []
    [ div [] [ text <| currency.base ++ " - " ++ currency.target ]
    , div [] [ text <| "$ " ++ currency.price ]
    , div [] [ text <| currency.change ]
    , div [] [ text <| currency.volume ]
    , marketTabsView currency.markets selectedMarket
    , marketView selectedMarket
    ]

marketTabsView : List Market -> Market -> Html Msg
marketTabsView markets selectedMarket =
  div [ class "tabs market__tabs" ]
    [ ul [] 
      ( List.map2 marketTabView markets (List.repeat (List.length markets) selectedMarket)) ]

marketTabView : Market -> Market -> Html Msg
marketTabView market selectedMarket =
  li [ classList [ ( "is-active", market == selectedMarket ) ] ]
    [ a [ onClick <| Msgs.SelectMarket market ]
      [ text market.market ] ]

marketView : Market -> Html Msg
marketView market =
  div []
    [ h2 [ class "market__name" ] [ text market.market ]
    , h2 [ class "market__price" ] [ text market.price ]
    , h2 [ class "market__volume" ] [ text <| toString market.volume ]
  ]