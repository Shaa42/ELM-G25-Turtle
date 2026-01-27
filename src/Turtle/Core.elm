module Turtle.Core exposing (Command(..), Line, Turtle, execCmds, initTurtle)

-- TURTLE
-- Defines the types of commands the turtle can execute


type Command
    = Forward Float
    | Right Float
    | Left Float
    | Repeat Int (List Command)



-- Represents the turtle's current position and angle


type alias Turtle =
    { x : Float
    , y : Float
    , angle : Float
    }



-- Represents a line segment drawn by the turtle


type alias Line =
    { x1 : Float
    , y1 : Float
    , x2 : Float
    , y2 : Float
    }



-- Initializes a new turtle


initTurtle : Turtle
initTurtle =
    { x = 0
    , y = 0
    , angle = 0
    }



-- Moves the turtle forward by the distance length, updating its position and returning the line segment drawn from the old to the new position.


forward : Float -> Turtle -> ( Turtle, Line )
forward length turtle =
    let
        newx =
            turtle.x + length * cos (degrees turtle.angle)

        newy =
            turtle.y + length * sin (degrees turtle.angle)

        line =
            { x1 = turtle.x
            , x2 = newx
            , y1 = turtle.y
            , y2 = newy
            }

        newTurtle =
            { turtle | x = newx, y = newy }
    in
    ( newTurtle, line )



-- Executes a single command: takes the current turtle and list of lines, returns the updated turtle and list (with a new line added if the command draws one)


execCmd : Command -> ( Turtle, List Line ) -> ( Turtle, List Line )
execCmd cmd ( turtle, lines ) =
    case cmd of
        Forward distance ->
            let
                ( newTurtle, newLine ) =
                    forward distance turtle
            in
            ( newTurtle, newLine :: lines )

        Right angle ->
            let
                newTurtle =
                    { turtle | angle = turtle.angle + angle }
            in
            ( newTurtle, lines )

        Left angle ->
            let
                newTurtle =
                    { turtle | angle = turtle.angle - angle }
            in
            ( newTurtle, lines )

        Repeat n commands ->
            let
                repeatCommands =
                    List.repeat n commands
                        |> List.concat
            in
            List.foldl execCmd ( turtle, lines ) repeatCommands



-- Executes a list of commands sequentially, returning the final turtle state and all accumulated lines drawn


execCmds : List Command -> Turtle -> List Line -> ( Turtle, List Line )
execCmds commands turtle lines =
    List.foldl execCmd ( turtle, lines ) commands
