module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Http
import Icons


type Msg
    = BoxerButtonClicked
    | GotBoxerResponse (Result Http.Error ())
    | ComputerButtonClicked
    | GotComputerResponse (Result Http.Error ())


goToButtons =
    div []
        [ div [ class "flex-end" ]
            [ button [ class "btn flex flex-col content-center" ]
                [ Icons.powerIcon
                , p [ class "sr-only" ] [ Html.text "Stäng av" ]
                ]
            ]
        , div [ class "flex flex-col" ]
            [ button [ Html.Events.onClick BoxerButtonClicked, class "btn flex flex-col content-center" ]
                [ Icons.tvIcon
                , p [ class "label text-white" ] [ Html.text "Gå till boxer" ]
                ]
            , button
                [ Html.Events.onClick ComputerButtonClicked, class "btn flex flex-col content-center" ]
                [ Icons.computerIcon
                , p [ class "label text-white" ] [ Html.text "Gå till dator" ]
                ]
            ]
        ]


subscriptions model =
    Sub.none


init : () -> ( String, Cmd Msg )
init flags =
    ( "hej", Cmd.none )


view model =
    goToButtons


update msg model =
    let
        _ =
            Debug.log "msg" msg
    in
    case msg of
        BoxerButtonClicked ->
            let
                request =
                    Http.get
                        { url = "/boxer"
                        , expect = Http.expectWhatever GotBoxerResponse
                        }
            in
            ( model, request )

        GotBoxerResponse (Ok _) ->
            let
                _ =
                    Debug.log "ok" "ok"
            in
            ( model, Cmd.none )

        GotBoxerResponse (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
            ( model, Cmd.none )

        ComputerButtonClicked ->
            let
                request =
                    Http.get
                        { url = "/computer"
                        , expect = Http.expectWhatever GotComputerResponse
                        }
            in
            ( model, request )

        GotComputerResponse (Ok _) ->
            let
                _ =
                    Debug.log "ok" "ok"
            in
            ( model, Cmd.none )

        GotComputerResponse (Err err) ->
            let
                _ =
                    Debug.log "error" err
            in
            ( model, Cmd.none )


main =
    Browser.element
        { subscriptions = subscriptions
        , init = init
        , view = view
        , update = update
        }
