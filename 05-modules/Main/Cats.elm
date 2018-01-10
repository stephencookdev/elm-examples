module Main.Cats exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    String


initialModel : Model
initialModel =
    ""



-- UPDATE


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


initialCmd : Cmd Msg
initialCmd =
    getRandomGif "cats"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( "", getRandomGif "cats" )

        NewGif (Ok newUrl) ->
            ( newUrl, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ if model == "" then
            text "Loading..."
          else
            button [ onClick MorePlease ] [ text "More Please!" ]
        , br [] []
        , img [ src model ] []
        ]



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, initialCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Helpers


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
        Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
