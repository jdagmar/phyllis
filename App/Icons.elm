module Icons exposing (..)

import Html exposing (..)
import Html.Attributes
import Svg exposing (..)
import Svg.Attributes exposing (d, fill, rx, ry, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox, x, y)


tvIcon =
    div [ Html.Attributes.class "icon text-white" ]
        [ svg
            [ viewBox "0 0 24 24"
            , fill "none"
            , stroke "currentColor"
            , strokeWidth "2"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ rect
                [ x "2"
                , y "7"
                , Svg.Attributes.width "20"
                , Svg.Attributes.height "15"
                , rx "2"
                , ry "2"
                ]
                []
            , Svg.path [ d "M17 2l-5 5-5-5" ] []
            ]
        ]


computerIcon =
    div [ Html.Attributes.class "icon text-white" ]
        [ svg
            [ viewBox "0 0 24 24"
            , fill "none"
            , stroke "currentColor"
            , strokeWidth "2"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ rect
                [ x "2"
                , y "3"
                , Svg.Attributes.width "20"
                , Svg.Attributes.height "14"
                , rx "2"
                , ry "2"
                ]
                []
            , Svg.path [ d "M8 21h8M12 17v4" ] []
            ]
        ]


powerIcon =
    div [ Html.Attributes.class "icon text-white icon-small icon-round bg-red content-center" ]
        [ svg
            [ viewBox "0 0 24 24"
            , fill "none"
            , stroke "currentColor"
            , strokeWidth "2"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            ]
            [ Svg.path [ d "M18.36 6.64a9 9 0 1 1-12.73 0M12 2v10" ] [] ]
        ]
