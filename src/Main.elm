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
    , eraseDrawing : String
    }


init : Model
init =
    { draftInput = "" 
    , committedInput = ""
    , eraseDrawing = ""
    }



-- UPDATE


type Msg
    = UpdateDraft String
    | CommitInput 
    | ClearDrawing



update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateDraft txt ->
            { model| draftInput = txt }
        CommitInput ->
            { model | committedInput = model.draftInput }
        ClearDrawing ->
            { model | committedInput = "", draftInput = ""}
-- VIEW


view : Model -> Html Msg
view model =
    div [ Html.Attributes.class "container" ]
        [ h1 [] [ Html.text "🐢TC Turtle🐢" ]
        , input
                [ placeholder "Enter your instructions senpai UwU"
                , value model.draftInput
                , Html.Events.onInput UpdateDraft
                , Html.Attributes.id "text-input"
                ]
                []
                , div [ Html.Attributes.class "row" ]
                    [ button [ onClick CommitInput ] [ Html.text "Draw" ]
                    , button [ onClick ClearDrawing ] [ Html.text "Erase" ]
                ]
                , p [] [ Html.text ("Input : " ++ model.committedInput) ]
                ,svg
        [ width "100%", height "100%", viewBox "-150 -100 300 200" ]
        [ rect
                [ x "-150", y "-100", width "300", height "200"
                , fill "none", stroke "black", strokeWidth "1"
                ]
                []
                
        , if model.committedInput /= "" then
                line 
                        [ x1 "0", y1 "0", x2 "50", y2 "50", stroke "black", strokeWidth "2" ] 
                        []
        else
                Html.text ""
        ]
        ]
        
        
