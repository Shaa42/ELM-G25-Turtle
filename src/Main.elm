module Main exposing (..)

-- Import Turtle module

import Browser
import Html exposing (Html, button, div, h1, input)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Turtle.Core exposing (Line, Turtle, execCmds, initTurtle)
import Turtle.Parser exposing (parseCommands)



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
    , turtle : Turtle
    , lines : List Line
    }


init : Model
init =
    { draftInput = ""
    , committedInput = ""
    , turtle = initTurtle
    , lines = []
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
            case parseCommands model.draftInput of
                Ok commands ->
                    let
                        ( newTurtle, newLines ) =
                            execCmds commands model.turtle model.lines
                    in
                    { model
                        | turtle = newTurtle
                        , lines = newLines
                        , committedInput = model.draftInput
                    }

                Err errorMsg ->
                    { model | committedInput = "Error: " ++ errorMsg }

        ClearDrawing ->
            { model | committedInput = "", turtle = initTurtle, lines = [] }



-- SVG FUNCTIONS


renderLine : Line -> Svg msg
renderLine l =
    line
        [ x1 (String.fromFloat l.x1)
        , y1 (String.fromFloat l.y1)
        , x2 (String.fromFloat l.x2)
        , y2 (String.fromFloat l.y2)
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "0.5"
        ]
        []



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
                            , Svg.Attributes.viewBox "0 0 24 24"
                            , Svg.Attributes.fill "none"
                            , Svg.Attributes.stroke "currentColor"
                            , Svg.Attributes.strokeWidth "2"
                            ]
                            [ Svg.path [ d "M20 5H9l-7 7 7 7h11a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2Z" ] []
                            , Svg.line [ x1 "18", y1 "9", x2 "12", y2 "15" ] []
                            , Svg.line [ x1 "12", y1 "9", x2 "18", y2 "15" ] []
                            ]
                        , Html.text "Erase"
                        ]
                    ]
                ]
            , div [ Html.Attributes.class "canvas-container" ]
                [ div [ Html.Attributes.class "canvas-header" ]
                    [ Html.span [ Html.Attributes.class "canvas-label" ] [ Html.text "Canvas" ] ]
                , svg
                    [ width "100%", height "100%", viewBox "-150 -100 300 200", Svg.Attributes.class "canvas-area" ]
                    [ rect
                        [ Svg.Attributes.x "-150"
                        , Svg.Attributes.y "-100"
                        , Svg.Attributes.width "300"
                        , Svg.Attributes.height "200"
                        , Svg.Attributes.fill "none"
                        , Svg.Attributes.strokeWidth "1"
                        ]
                        []
                    , if model.committedInput /= "" then
                        Svg.g [] (List.map renderLine model.lines)

                      else
                        Svg.g [] []
                    ]
                ]
            ]
        , Html.footer [ Html.Attributes.class "footer" ]
            [ Html.p [] [ Html.text "Made by Ryan, Taiga and Dương" ] ]
        ]
