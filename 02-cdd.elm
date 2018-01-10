module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { counter : Int }


initialModel : Model
initialModel =
    { counter = 0 }


type Msg
    = IncrementCounter
    | DecrementCounter
    | ResetCounter


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncrementCounter ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        DecrementCounter ->
            ( { model | counter = model.counter - 1 }, Cmd.none )

        ResetCounter ->
            ( { model | counter = 0 }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "button", value "Upper", onClick IncrementCounter ] []
        , div [] [ text (toString model.counter) ]
        , div []
            (List.map
                (\i ->
                    img
                        [ src (String.concat [ "./doggos/", (toString i), ".jpg" ])
                        , height 300
                        ]
                        []
                )
                (List.range 1 model.counter)
            )
        , input [ type_ "button", value "Downer", onClick DecrementCounter ] []
        , input [ type_ "button", value "Reset", onClick ResetCounter ] []
        ]


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
