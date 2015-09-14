module App where

import Debug
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (action, attribute, class, for, id, type')
import Html.Events exposing (on, onClick, targetValue)
import String

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

isValidName : String -> Bool
isValidName =
  not << String.isEmpty

isValidAge : String -> Bool
isValidAge value =
  case String.toInt value of
    Ok int ->
      int >= 0
    Err _ ->
      False

isValid : Model -> Bool
isValid model =
  isValidName model.name && isValidAge model.age

-- UPDATE

type Action
  = NoOp
  | SetName String
  | SetAge String
  | SetErrors
  | Submit


update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    SetName name' ->
      { model | name <- name' }

    SetAge age' ->
      { model | age <- age' }

    SetErrors ->
      let name = if isValidName model.name
                 then IsOkay
                 else HasError "Please enter your name"
          age = if isValidAge model.age
                then IsOkay
                else HasError "Please enter your age as a whole number"
          errors' = Dict.fromList [("name", name), ("age", age)]
      in
        { model | errors <- errors' }

    Submit ->
      model


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
    , button [ class "btn btn-default"
             , onClick actions.address <| if isValid model then Submit else SetErrors
             ]
      [ text "Submit" ]
    ]
  ]
