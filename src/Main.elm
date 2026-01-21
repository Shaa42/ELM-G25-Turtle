module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, input, p, text)
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
    { draftInput : String
    , committedInput : String
    }


init : Model
init =
    { draftInput = "" 
    , committedInput = ""
    }



-- UPDATE


type Msg
    = UpdateDraft String
    | CommitInput 



update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateDraft txt ->
            { model | draftInput = txt }
        CommitInput ->
            { model | committedInput = model.draftInput }

-- VIEW


view : Model -> Html Msg
view model =
    div [ Html.Attributes.class "container" ]
        [ h1 [] [ Html.text "TC Turtle" ]
        , input
                [ placeholder "Text place holder"
                , value model.draftInput
                , Html.Events.onInput UpdateDraft
                , Html.Attributes.id "text-input"
                ]
                []
                , button [ onClick CommitInput ] [ Html.text "Draw" ]
                , p [] [ Html.text ("Input : " ++ model.committedInput) ]
                ,svg
        [ width "100%", height "100%", viewBox "-150 -100 300 200" ]
        [ rect
                [ x "-150", y "-100", width "300", height "200"
                , fill "none", stroke "black", strokeWidth "1"
                ]
                []
        ]
        ]
