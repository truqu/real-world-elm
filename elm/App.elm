module App where

import Debug
import Html exposing (..)
import Html.Attributes exposing (class)
import Http
import Json.Decode exposing ((:=))
import Task exposing (Task, andThen)


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

    SetArtists model' ->
      model'


-- SIGNALS

main : Signal Html
main =
  Signal.map view model


model : Signal Model
model = Signal.foldp update init actions.signal


actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp


get : Task Http.Error (List Artist)
get =
  Http.get (Json.Decode.list artist) "/api/artists"


port runner : Task Http.Error ()
port runner =
  get `andThen` (SetArtists >> Signal.send actions.address)


-- VIEW

view : Model -> Html
view model =
  let th' field = th [] [text field]
      tr' artist = tr [] [ td [] [text <| toString artist.id]
                         , td [] [text <| artist.name]
                         ]
  in
    div [class "container"]
    [ table [class "table table-striped table-bordered"]
      [ thead [] [tr [] (List.map th' ["ID", "name"])]
      , tbody [] (List.map tr' model)
      ]
    ]
