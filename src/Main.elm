module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Time exposing (Time)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

-- MODEL

type alias Model =
    { time : Time, paused : Bool }

init : ( Model, Cmd Msg )
init =
    ( { time = 25 * Time.minute, paused = False }, Cmd.none )

-- UPDATE

type Msg
    = Tick Time
    | Code
    | Social
    | Coffee
    | Play
    | Pause


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            case model.paused of
                True ->
                    ( model, Cmd.none )

                False ->
                    ( { model | time = model.time - Time.second }, Cmd.none )

        Code ->
            ( { model | time = 25 * Time.minute, paused = False }, Cmd.none )

        Social ->
            ( { model | time = 5 * Time.minute, paused = False }, Cmd.none )

        Coffee ->
            ( { model | time = 15 * Time.minute, paused = False }, Cmd.none )

        Play ->
            ( { model | paused = False }, Cmd.none )

        Pause ->
            ( { model | paused = True }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick



-- VIEW


showTime : Time -> String
showTime time =
    let
        minutes_ =
            toString (floor (time / Time.minute))

        seconds_ =
            round (time) % round (Time.minute) // round (Time.second) |> toString
    in
        minutes_ ++ ":" ++ seconds_


view : Model -> Html Msg
view model =
    div
        [ class "clearfix mxn2" ]
        [ div [class "main-container col-4 px2 mx-auto"]
            [ div [class "timeContainer"]
                [ span [ class "time center" ] [ model.time |> showTime |> text ]
                , span [ class "timeMessage center"] [ text "It's code time" ]
                ]
            , div [ class "messages center" ]
                [ button [ class "btn", onClick Code ] [ text "Code" ]
                , button [ class "btn", onClick Social ] [ text "Social" ]
                , button [ class "btn", onClick Coffee ] [ text "Coffee" ]
                ]
            , div [ class "controls center" ]
                [ button [ class "btn", onClick Play ] [ text "Play" ]
                , button [ class "btn", onClick Pause ] [ text "Pause" ]
                ]
            ]
        ]
