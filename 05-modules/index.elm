module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Main.Password
import Main.Cats


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { showCats : Bool
    , passwordModel : Main.Password.Model
    , catsModel : Main.Cats.Model
    }


initialModel : Model
initialModel =
    { showCats = True
    , passwordModel = Main.Password.initialModel
    , catsModel = Main.Cats.initialModel
    }



-- UPDATE


type Msg
    = ShowCats
    | ShowPass
    | PasswordMsg Main.Password.Msg
    | CatMsg Main.Cats.Msg


initialCmd : Cmd Msg
initialCmd =
    Cmd.batch
        [ Cmd.map PasswordMsg Main.Password.initialCmd
        , Cmd.map CatMsg Main.Cats.initialCmd
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowCats ->
            ( { model | showCats = True }, Cmd.none )

        ShowPass ->
            ( { model | showCats = False }, Cmd.none )

        PasswordMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Main.Password.update subMsg model.passwordModel
            in
                ( { model | passwordModel = updatedWidgetModel }, Cmd.map PasswordMsg widgetCmd )

        CatMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Main.Cats.update subMsg model.catsModel
            in
                ( { model | catsModel = updatedWidgetModel }, Cmd.map CatMsg widgetCmd )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "button", value "Show cats", onClick ShowCats ] []
        , input [ type_ "button", value "Show pass", onClick ShowPass ] []
        , (if model.showCats then
            Html.map CatMsg (Main.Cats.view model.catsModel)
           else
            Html.map PasswordMsg (Main.Password.view model.passwordModel)
          )
        ]



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
