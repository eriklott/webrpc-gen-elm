module Main exposing (main)

import Api
import Browser exposing (Document)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task exposing (Task)


main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { message : String }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Hello World", Cmd.none )


type Msg
    = ClickedGetEmpty
    | ClickedGetError
    | ClickedGetOne
    | ClickedSendOne
    | ClickedGetMulti
    | ClickedSendMulti
    | ClickedGetComplex
    | ClickedSendComplex
    | ClickedGetSchemaError
    | CompletedGetEmpty (Result Api.Error ())
    | CompletedGetError (Result Api.Error ())
    | CompletedGetOne (Result Api.Error Api.Simple)
    | CompletedSendOne (Result Api.Error ())
    | CompletedGetMulti (Result Api.Error { one : Api.Simple, two : Api.Simple, three : Api.Simple })
    | CompletedSendMulti (Result Api.Error ())
    | CompletedGetComplex (Result Api.Error Api.Complex)
    | CompletedSendComplex (Result Api.Error ())
    | CompletedGetSchemaError (Result Api.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedGetEmpty ->
            ( { model | message = "loading" }
            , Api.testApi.getEmpty |> Api.send CompletedGetEmpty
            )

        ClickedGetError ->
            ( { model | message = "loading" }
            , Api.testApi.getError |> Api.send CompletedGetError
            )

        ClickedGetOne ->
            ( { model | message = "loading" }
            , Api.testApi.getOne |> Api.send CompletedGetOne
            )

        ClickedSendOne ->
            ( { model | message = "loading" }
            , Api.testApi.getOne
                |> Api.task
                |> Task.andThen (Api.testApi.sendOne >> Api.task)
                |> Task.attempt CompletedSendOne
            )

        ClickedGetMulti ->
            ( { model | message = "loading" }
            , Api.testApi.getMulti |> Api.send CompletedGetMulti
            )

        ClickedSendMulti ->
            ( { model | message = "loading" }
            , Api.testApi.getMulti
                |> Api.task
                |> Task.andThen (\{ one, two, three } -> Api.testApi.sendMulti one two three |> Api.task)
                |> Task.attempt CompletedSendMulti
            )

        ClickedGetComplex ->
            ( { model | message = "loading" }
            , Api.testApi.getComplex |> Api.send CompletedGetComplex
            )

        ClickedSendComplex ->
            ( { model | message = "loading" }
            , Api.testApi.getComplex
                |> Api.task
                |> Task.andThen (Api.testApi.sendComplex >> Api.task)
                |> Task.attempt CompletedSendComplex
            )

        ClickedGetSchemaError ->
            ( { model | message = "loading" }
            , Api.testApi.getSchemaError 1 |> Api.send CompletedGetSchemaError
            )

        CompletedGetEmpty result ->
            ( { model | message = "CompletedGetEmpty: " ++ resultToString result }
            , Cmd.none
            )

        CompletedGetError result ->
            ( { model | message = "CompletedGetError: " ++ resultToString result }
            , Cmd.none
            )

        CompletedGetOne result ->
            ( { model | message = "CompletedGetOne: " ++ resultToString result }
            , Cmd.none
            )

        CompletedSendOne result ->
            ( { model | message = "CompletedSendOne: " ++ resultToString result }
            , Cmd.none
            )

        CompletedGetMulti result ->
            ( { model | message = "CompletedGetMulti: " ++ resultToString result }
            , Cmd.none
            )

        CompletedSendMulti result ->
            ( { model | message = "CompletedSendMulti: " ++ resultToString result }
            , Cmd.none
            )

        CompletedGetComplex result ->
            ( { model | message = "CompletedGetComplex: " ++ resultToString result }
            , Cmd.none
            )

        CompletedSendComplex result ->
            ( { model | message = "CompletedSendComplex: " ++ resultToString result }
            , Cmd.none
            )

        CompletedGetSchemaError result ->
            ( { model | message = "CompletedGetSchemaError: " ++ resultToString result }
            , Cmd.none
            )


resultToString : Result Api.Error a -> String
resultToString result =
    case result of
        Ok _ ->
            "Ok"

        Err _ ->
            "Err"


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Document Msg
view model =
    { title = "Hello World"
    , body =
        [ div [ id "message" ] [ text model.message ]
        , button [ id "getEmptyBtn", onClick ClickedGetEmpty ] [ text "getEmpty" ]
        , button [ id "getErrorBtn", onClick ClickedGetError ] [ text "getError" ]
        , button [ id "getOneBtn", onClick ClickedGetOne ] [ text "getOne" ]
        , button [ id "sendOneBtn", onClick ClickedSendOne ] [ text "sendOne" ]
        , button [ id "getMultiBtn", onClick ClickedGetMulti ] [ text "getMulti" ]
        , button [ id "sendMultiBtn", onClick ClickedSendMulti ] [ text "sendMulti" ]
        , button [ id "getComplexBtn", onClick ClickedGetComplex ] [ text "getComplex" ]
        , button [ id "sendComplexBtn", onClick ClickedSendComplex ] [ text "sendComplex" ]
        , button [ id "getSchemaErrorBtn", onClick ClickedGetSchemaError ] [ text "getSchemaError" ]
        ]
    }
