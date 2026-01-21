module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, header, input, label, p, text)
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
            { model | draftInput = txt }

        CommitInput ->
            { model | committedInput = model.draftInput }

        ClearDrawing ->
            { model | committedInput = "", draftInput = "" }



-- VIEW


view : Model -> Html Msg
view model =
    div [ Html.Attributes.class "app-wrapper" ]
        [ Html.header [ Html.Attributes.class "header" ]
            [ h1 [ Html.Attributes.class "logo" ]
                [ Html.span [ Html.Attributes.class "turtle-icon" ] [ Html.text "🐢" ]
                , Html.text "TC Turtle"
                , Html.span [ Html.Attributes.class "turtle-icon" ] [ Html.text "🐢" ]
                ]
            ]
        , Html.main_ [ Html.Attributes.class "main-content" ]
            [ div [ Html.Attributes.class "control-panel" ]
                [ div [ Html.Attributes.class "input-group" ]
                    [ Html.label
                        [ Html.Attributes.for "text-input", Html.Attributes.class "input-label" ]
                        [ Html.text "Instructions" ]
                    , input
                        [ placeholder "Enter your instructions here"
                        , Html.Attributes.type_ "text"
                        , Html.Attributes.id "text-input"
                        , Html.Attributes.class "text-input"
                        , value model.draftInput
                        , Html.Events.onInput UpdateDraft
                        ]
                        []
                    ]
                , div [ Html.Attributes.class "button-group" ]
                    [ button [ onClick CommitInput, Html.Attributes.class "btn btn-primary" ]
                        [ svg
                            [ Svg.Attributes.class "btn-icon"
                            , viewBox "0 0 24 24"
                            , fill "none"
                            , stroke "currentColor"
                            , strokeWidth "2"
                            ]
                            [ Svg.path [ d "M12 19l7-7 3 3-7 7-3-3z" ] []
                            , Svg.path [ d "M18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5z" ] []
                            , Svg.path [ d "M2 2l7.586 7.586" ] []
                            , circle [ cx "11", cy "11", r "2" ] []
                            ]
                        , Html.text "Draw"
                        ]
                    , button [ onClick ClearDrawing, Html.Attributes.class "btn btn-secondary" ]
                        [ svg
                            [ Svg.Attributes.class "btn-icon"
                            , viewBox "0 0 24 24"
                            , fill "none"
                            , stroke "currentColor"
                            , strokeWidth "2"
                            ]
                            [ Svg.path [ d "M20 5H9l-7 7 7 7h11a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2Z" ] []
                            , line [ x1 "18", y1 "9", x2 "12", y2 "15" ] []
                            , line [ x1 "12", y1 "9", x2 "18", y2 "15" ] []
                            ]
                        , Html.text "Erase"
                        ]
                    ]
                ]
            , div [ Html.Attributes.class "canvas-container" ]
                [ div [ Html.Attributes.class "canvas-header" ]
                    [ Html.span [ Html.Attributes.class "canvas-label" ] [ Html.text "Canvas" ] ]
                , svg
                    [ width "100%", height "100%", viewBox "-150 -50 300 100", Svg.Attributes.class "canvas-area" ]
                    [ rect
                        [ x "-150"
                        , y "-50"
                        , width "300"
                        , height "100"
                        , fill "none"
                        ]
                        []
                    , if model.committedInput /= "" then
                        line
                            [ x1 "-5", y1 "0", x2 "5", y2 "0", stroke "black", strokeWidth "2" ]
                            []

                      else
                        Html.text ""
                    ]
                ]
            ]
        , Html.footer [ Html.Attributes.class "footer" ]
            [ Html.p [] [ Html.text "Made by Ryan, Taiga and Dương" ] ]
        ]
