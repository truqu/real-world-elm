module App where

import Html exposing (Html)
import Json.Decode exposing ((:=))


-- MODEL

type alias Artist =
  { id: Int
  , name: String
  }


artist : Json.Decode.Decoder Artist
artist =
  Json.Decode.object2 Artist
    ("id" := Json.Decode.int)
    ("name" := Json.Decode.string)


type alias Model =
  List Artist


init : Model
init =
  []


-- UPDATE

type Action
  = NoOp
  | SetArtists (List Artist)


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetArtists artists ->
      artists


-- SIGNALS

main : Signal Html
main =
  Signal.map view model


model : Signal Model
model = Signal.foldp update init actions.signal


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp



-- VIEW

view : Model -> Html
view model =
  Html.div [] [ Html.text "TODO" ]
