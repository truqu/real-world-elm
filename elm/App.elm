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
  , inputState: Dict String InputState
  }


init : Model
init =
  { name = ""
  , age = ""
  , inputState = Dict.empty
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


type alias InputParams =
  { id: String
  , label: String
  , type': String
  , action: String -> Action
  }


-- UPDATE

type Action
  = NoOp
  | SetName String
  | SetAge String
  | SetInputState
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

    SetInputState ->
      let name = if isValidName model.name
                 then IsOkay
                 else HasError "Please enter your name"
          age = if isValidAge model.age
                then IsOkay
                else HasError "Please enter your age as a whole number"
          inputState' = Dict.fromList [("name", name), ("age", age)]
      in
        { model | inputState <- inputState' }

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
    [ nameInput model
    , ageInput model
    , button [ class "btn btn-default"
             , onClick actions.address <| if isValid model then Submit else SetInputState
             ]
      [ text "Submit" ]
    ]
  ]


nameInput : Model -> Html
nameInput =
  input' { id = "name"
         , label = "name"
         , type' = "text"
         , action = SetName
         }


ageInput : Model -> Html
ageInput =
  input' { id = "age"
         , label = "age"
         , type' = "text"
         , action = SetAge
         }


input' : InputParams -> Model -> Html
input' params model =
  let state = case Dict.get params.id model.inputState of
                Nothing -> Initial
                Just value -> value
  in
    div [ class <| case state of
                     Initial ->
                       "form-group"
                     HasError _ ->
                       "form-group has-feedback has-error"
                     IsOkay ->
                       "form-group has-feedback has-success"
        ]
    [ label [ for params.id ] [ text params.label ]
    , input [ id params.id, type' params.type' , class "form-control"
            , on "input" targetValue
                   (Signal.message actions.address << params.action)
            ]
      []
    , span [ class <| case state of
                        Initial ->
                          "glyphicon glyphicon-blank form-control-feedback"
                        HasError _ ->
                          "glyphicon glyphicon-remove form-control-feedback"
                        IsOkay ->
                          "glyphicon glyphicon-ok form-control-feedback"
           ]
      []
    , span [ class "help-block" ]
      [ case state of
          HasError error -> text error
          _ -> text ""
      ]
    ]
