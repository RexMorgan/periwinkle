module Layout.Heading exposing (..)

import Html exposing (Html, div, text, nav, a, span, hr)
import Models exposing (Model, Route(..))
import Msgs exposing (Msg)
import Html.Attributes exposing (class, href, id)
import Html.Attributes.Aria exposing(..)

headingBar : Html Msg
headingBar =
    div []
        [ menuBar ]

menuBar : Html Msg
menuBar =
    nav[class "navbar has-shadow is-spaced"
        , role "navigation"
        , ariaLabel "dropdown navigation"
        , id "navbar"]
        [
            div[class "container"]
                [
                    div[class "navbar-brand"]
                        [
                            a[class "navbar-item"
                            , href "/"]
                                [text "brand"]
                            , menuBurger
                        ]
                    , div[class "navbar-menu"]
                        [navEndBar]
                 ]
        ]

menuBurger : Html Msg
menuBurger =
    a[role "button"
    , class "navbar-burger"
    , ariaLabel "menu"]
        [
            span[ariaHidden True][]
            , span[ariaHidden True][]
            , span[ariaHidden True][]
        ]

navEndBar : Html Msg
navEndBar =
    div[class "navbar-end"]
        [userDropdown]

userDropdown : Html Msg
userDropdown =
    div[class "navbar-item has-dropdown is-hoverable"]
        [
            a[class "navbar-link"]
                [text("user")]
            , div[class "navbar-dropdown is-right"]
                [
                    a[class "navbar-item"]
                        [text("Profile")]
                    , a[class "navbar-item"]
                        [text("Settings")]
                    , hr[class "navbar-divider"][]
                    , a[class "navbar-item"]
                        [text("Sign Out")]
                ]
        ]