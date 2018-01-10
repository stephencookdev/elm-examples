module MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, img)
import Css.Namespace exposing (namespace)


type CssClasses
    = MyHeading


css =
    (stylesheet << namespace "myStaticNamespace")
        [ body
            [ margin zero
            , padding zero
            ]
        , class MyHeading
            [ backgroundColor (rgb 200 50 20)
            , color (hex "001144")
            , fontSize (px 32)
            ]
        , img
            [ width (px 400)
            ]
        ]


myBestColor =
    hex "ee4400"
