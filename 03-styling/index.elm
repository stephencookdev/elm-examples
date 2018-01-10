module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers
import MyCss


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    Int


initialModel : Model
initialModel =
    0


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---------------------------------------


{ class } =
    Html.CssHelpers.withNamespace "myStaticNamespace"


view : Model -> Html Msg
view model =
    div []
        [ Html.node "link" [ Html.Attributes.rel "stylesheet", Html.Attributes.href "generated-03.css" ] []
        , h1 [ class [ MyCss.MyHeading ] ] [ text "Such Styling" ]
        , img [ src "css-cat.jpg" ] []
        ]
