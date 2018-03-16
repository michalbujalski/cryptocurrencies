module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Models exposing (..)
import Updates exposing (update)
import Msgs exposing (Msg)
import RemoteData exposing (..)
import Commands exposing (..)
---- MODEL ----


init : ( Model, Cmd Msg )
init =
    ( defaultModel, fetchCurrency currencyUrl)



-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , currencyView model
        ]

currencyView : Model -> Html Msg
currencyView model =
  case model.currency of
      Loading ->
          div [] [ text "loading" ]
      NotAsked ->
          div [] []
      Failure failure ->
          div [] [ text <| toString failure ]
      Success payload ->
          div [] [ text payload.base ]
          


---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = Updates.update
        , subscriptions = always Sub.none
        }
