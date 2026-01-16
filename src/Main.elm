module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (id, placeholder, value)
import Html.Events exposing (onClick, onInput)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { inputValue : String }


init : Model
init =
    { inputValue = "" }



-- UPDATE


type Msg
    = UpdateInput String
    | DrawButtonClicked


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateInput newValue ->
            { model | inputValue = newValue }

        DrawButtonClicked ->
            Debug.log model.inputValue
                model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input
            [ placeholder "Text place holder"
            , value model.inputValue
            , onInput UpdateInput
            , id "text-input"
            ]
            []
        , button
            [ onClick DrawButtonClicked
            ]
            [ text "Draw" ]
        , p [] [ text ("Vous avez écrit: " ++ model.inputValue) ]
        ]
