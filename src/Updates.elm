module Updates exposing (..)
import Msgs exposing (Msg)
import Models exposing (Model)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      Msgs.UpdateCurrency currency ->
        ( { model | currency = currency }, Cmd.none )
          
