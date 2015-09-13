module App where

import Debug
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (action, attribute, class, for, id, type')
import Html.Events exposing (on, targetValue)


-- MODEL

type alias Model =
  { name: String
  , age: String
  , errors: Dict String InputState
  }


init : Model
init =
  { name = ""
  , age = ""
  , errors = Dict.empty
  }


type InputState
  = Initial
  | HasError String
  | IsOkay


-- UPDATE

type Action
  = NoOp
  | SetName String
  | SetAge String


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetName name' ->
      { model | name <- name' }

    SetAge age' ->
      { model | age <- age' }


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
  div [ class "container" ]
  [ div [ attribute "role" "form" ]
    [ div [ class "form-group" ]
      [ label [ for "name" ]
        [ text "name" ]
      , input [ id "name", type' "text" , class "form-control"
              , on "input" targetValue
                     (Signal.message actions.address << SetName)
              ]
        []
      ]
    , div [ class "form-group" ]
      [ label [ for "age" ]
        [ text "age" ]
      , input [ id "age", type' "text" , class "form-control"
              , on "input" targetValue
                     (Signal.message actions.address << SetAge)
              ]
             []
      ]
    , button [ class "btn btn-default" ]
      [ text "Submit" ]
    ]
  ]
