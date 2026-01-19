module Main exposing (..)

import Browser
import Html exposing (Html, button, div, input, p, text)
import Html.Attributes exposing (class, id, placeholder, value)
import Html.Events exposing (onClick, onInput)
import Svg exposing (..)
import Svg.Attributes exposing (..)



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


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateInput newValue ->
            { model | inputValue = newValue }



-- VIEW


view : Model -> Html Msg
view model =
    div [ Html.Attributes.class "box" ]
        [ input
            [ placeholder "Text place holder"
            , value model.inputValue
            , onInput UpdateInput
            , Html.Attributes.id "text-input"
            ]
            []
        , p [] [ Html.text ("Input : " ++ model.inputValue) ]
        , svg
            [ viewBox "0 0 500 500"
            , width "500"
            , height "500"
            ]
            []
        ]
