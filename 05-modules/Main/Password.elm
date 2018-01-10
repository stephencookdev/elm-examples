module Main.Password exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { user : String
    , pass : String
    , passConfirm : String
    , showPass : Bool
    }


initialModel : Model
initialModel =
    { user = ""
    , pass = ""
    , passConfirm = ""
    , showPass = True
    }



-- UPDATE


type Msg
    = ChangeUser String
    | ChangePass String
    | ChangePassConfirm String
    | ChangeShowPass


initialCmd : Cmd Msg
initialCmd =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUser newUser ->
            ( { model | user = newUser }, Cmd.none )

        ChangePass newPass ->
            ( { model | pass = newPass }, Cmd.none )

        ChangePassConfirm newPassConfirm ->
            ( { model | passConfirm = newPassConfirm }, Cmd.none )

        ChangeShowPass ->
            ( { model | showPass = not model.showPass }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        passType =
            if model.showPass then
                "text"
            else
                "password"
    in
        div []
            [ input
                [ type_ "text"
                , placeholder "Username"
                , onInput ChangeUser
                , value model.user
                ]
                []
            , input
                [ type_ passType
                , placeholder "Password"
                , onInput ChangePass
                , value model.pass
                ]
                []
            , input
                [ type_ passType
                , placeholder "Confirm Password"
                , onInput ChangePassConfirm
                , value model.passConfirm
                ]
                []
            , label []
                [ input
                    [ type_ "checkbox"
                    , onClick ChangeShowPass
                    , checked model.showPass
                    ]
                    []
                , text "Show password"
                ]
            , (if model.showPass then
                div [ style [ ( "background", "red" ) ] ]
                    [ text "Warning, password is showing!" ]
               else
                text ""
              )
            , validationView model
            ]


validationView : Model -> Html Msg
validationView model =
    let
        result =
            if model.pass == model.passConfirm then
                div [ style [ ( "background", "green" ) ] ] [ text "All good" ]
            else
                div [ style [ ( "background", "red" ) ] ] [ text "All bad" ]
    in
        result



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
