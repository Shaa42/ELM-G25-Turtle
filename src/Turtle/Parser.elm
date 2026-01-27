module Turtle.Parser exposing (parseCommands)

import Parser exposing (..)
import Turtle.Core exposing (Command(..))



-- PARSER


numberParser : Parser Float
numberParser =
    Parser.oneOf
        [ Parser.float
        , Parser.int |> Parser.map toFloat
        ]


forwardParser : Parser Command
forwardParser =
    Parser.succeed Forward
        |. Parser.keyword "Forward"
        |. Parser.spaces
        |= numberParser


rightParser : Parser Command
rightParser =
    Parser.succeed Right
        |. Parser.keyword "Right"
        |. Parser.spaces
        |= numberParser


leftParser : Parser Command
leftParser =
    Parser.succeed Left
        |. Parser.keyword "Left"
        |. Parser.spaces
        |= numberParser


commandParser : Parser Command
commandParser =
    Parser.oneOf
        [ Parser.lazy (\_ -> repeatParser)
        , forwardParser
        , rightParser
        , leftParser
        ]


repeatParser : Parser Command
repeatParser =
    Parser.succeed Repeat
        |. Parser.keyword "Repeat"
        |. Parser.spaces
        |= Parser.int
        |. Parser.spaces
        |. Parser.symbol "["
        |. Parser.spaces
        |= Parser.sequence
            { start = ""
            , separator = ","
            , end = "]"
            , spaces = Parser.spaces
            , item = Parser.lazy (\_ -> commandParser)
            , trailing = Parser.Forbidden
            }


commandsParser : Parser (List Command)
commandsParser =
    Parser.succeed identity
        |. Parser.symbol "["
        |. Parser.spaces
        |= Parser.sequence
            { start = ""
            , separator = ","
            , end = "]"
            , spaces = Parser.spaces
            , item = commandParser
            , trailing = Parser.Forbidden
            }



-- Take a full command input and return a list of commands


parseCommands : String -> Result String (List Command)
parseCommands input =
    case Parser.run commandsParser input of
        Ok commands ->
            Ok commands

        Err _ ->
            Err "Invalid syntax! Use format: [ Forward 50, Right 90 ]"
