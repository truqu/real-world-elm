module Page.Index (Model, init, update, view) where

import Data.Artist exposing (Artist)
import Debug
import Html exposing (..)
import Html.Attributes exposing (class)


-- MODEL

type Model =
  Undefined

init : Model
init =
  Undefined


-- UPDATE

type Action
  = NoOp


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model


-- VIEW

view : Model -> Html
view model =
  div [class "container"]
  [ text "TODO" ]
