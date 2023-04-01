module MainTests exposing (..)

import API
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Process
import ProgramTest
import Task
import Test exposing (..)
import Test.Html.Selector as Selector


type alias Model =
    { message : String }


type Msg
    = ClickedGetEmpty
    | ClickedSleep
    | GetEmptyCompleted (Result API.Error ())
    | NoOp


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.message ]
        , button [ onClick ClickedGetEmpty ] [ text "GetEmpty" ]
        , button [ onClick ClickedSleep ] [ text "Sleep" ]
        ]


init : () -> ( Model, Cmd Msg )
init _ =
    ( { message = "initialized" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedGetEmpty ->
            ( { model | message = "waiting" }, API.testApi.getEmpty GetEmptyCompleted |> API.send )

        ClickedSleep ->
            ( model, Process.sleep 5000 |> Task.perform (always NoOp) )

        GetEmptyCompleted result ->
            case result of
                Ok () ->
                    ( { model | message = "GetEmptyCompleted: Success" }, Cmd.none )

                Err error ->
                    ( { model | message = "GetEmptyCompleted: Error" }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


suite : Test
suite =
    describe "Test interoperability with webrpc-test reference server"
        [ test "'getEmpty()' should get empty type successfully" <|
            \() ->
                ProgramTest.createElement
                    { init = init
                    , update = update
                    , view = view
                    }
                    |> ProgramTest.start ()
                    |> ProgramTest.clickButton "GetEmpty"
                    |> ProgramTest.clickButton "Sleep"
                    |> ProgramTest.expectViewHas [ Selector.text "waiting" ]
        ]
