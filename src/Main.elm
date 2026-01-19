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
            { model| draftInput = txt }
        CommitInput ->
            { model | committedInput = model.draftInput }

-- VIEW


view : Model -> Html Msg
view model =
    div [ Html.Attributes.class "box" ]
            [ input
                [ placeholder "Text place holder"
                , value model.draftInput
                , Html.Events.onInput UpdateDraft
                , Html.Attributes.id "text-input"
                ]
                []
                , button [ onClick CommitInput ] [ Html.text "Draw" ]
                , p [] [ Html.text ("Input : " ++ model.committedInput) ]
                ,svg
        [ width "90%", height "70%", viewBox "-200 -200 400 400" ]
        [ rect
                [ x "-200", y "-200", width "400", height "400"
                , fill "none", stroke "black", strokeWidth "1"
                ]
                []
        ]
        ]
