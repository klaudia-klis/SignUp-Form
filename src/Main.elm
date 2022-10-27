module Main exposing (Gender(..), Model, Msg(..), Plan(..), init, main, readPlan, showGender, showPlan, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { firstName : String
    , age : Maybe Int
    , income : String
    , moreInfo : String
    , gender : Maybe Gender
    , plan : Maybe Plan
    , subscribe : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            { firstName = ""
            , age = Nothing
            , income = ""
            , moreInfo = ""
            , gender = Nothing
            , plan = Nothing
            , subscribe = False
            }
    in
    ( model, Cmd.none )


type Gender
    = Male
    | Female
    | Trans


type Plan
    = Plan1
    | Plan2
    | Plan3



-- UPDATE


type Msg
    = SetFirstName String
    | SetAge String
    | SetIncome String
    | SetMoreInfo String
    | SetGender Gender
    | SetPlan String
    | ToggleSubscription


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetFirstName s ->
            ( { model | firstName = s }, Cmd.none )

        SetAge s ->
            case String.toInt s of
                Nothing ->
                    ( { model | age = Nothing }, Cmd.none )

                Just n ->
                    ( { model | age = Just n }, Cmd.none )

        SetIncome s ->
            ( { model | income = s }, Cmd.none )

        SetMoreInfo s ->
            ( { model | moreInfo = s }, Cmd.none )

        SetGender gender ->
            ( { model | gender = Just gender }, Cmd.none )

        SetPlan plan ->
            ( { model | plan = readPlan plan }, Cmd.none )

        ToggleSubscription ->
            ( { model | subscribe = not model.subscribe }, Cmd.none )


showGender : Gender -> String
showGender gender =
    case gender of
        Male ->
            "Male"

        Female ->
            "Female"

        Trans ->
            "Trans"


showPlan : Plan -> String
showPlan plan =
    case plan of
        Plan1 ->
            "1"

        Plan2 ->
            "2"

        Plan3 ->
            "3"


readPlan : String -> Maybe Plan
readPlan plan =
    case plan of
        "1" ->
            Just Plan1

        "2" ->
            Just Plan2

        "3" ->
            Just Plan3

        _ ->
            Nothing



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "text-align" "center"
        , style "background-color" "#F0F0F0"
        , style "max-width" "700px"
        , style "margin" "auto"
        , style "font-family" "Times New Roman"
        ]
        [ h1 [] [ text "Sign up" ]
        , label [ style "font-weight" "bold" ] [ text "First name" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ onInput SetFirstName ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "Age" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ onInput SetAge ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "Gender" ]
        , div
            [ style "padding" "10px 0 20px 0" ]
            [ input [ type_ "radio", name "gender", onClick (SetGender Male) ] []
            , label [ style "margin" "5px 10px 5px 2px" ] [ text "Male" ]
            , input [ type_ "radio", name "gender", onClick (SetGender Female) ] []
            , label [ style "margin" "5px 10px 5px 2px" ] [ text "Female" ]
            , input [ type_ "radio", name "gender", onClick (SetGender Trans) ] []
            , label [ style "margin" "5px 10px 5px 2px" ] [ text "I prefer not to answer" ]
            ]
        , label [ style "font-weight" "bold" ] [ text "Income" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ onInput SetIncome ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "More info" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ onInput SetMoreInfo ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "Plan" ]
        , div
            [ style "padding" "10px 0 10px 0"
            ]
            [ input [ id "plan1", type_ "radio", name "plan", onClick (SetPlan (showPlan Plan1)) ] []
            , label ([ for "plan1" ] ++ planStyle) [ text "Select Plan 1" ]
            , input [ id "plan2", type_ "radio", name "plan", onClick (SetPlan (showPlan Plan2)) ] []
            , label ([ for "plan2" ] ++ planStyle) [ text "Select Plan 2" ]
            , input [ id "plan3", type_ "radio", name "plan", onClick (SetPlan (showPlan Plan3)) ] []
            , label ([ for "plan3" ] ++ planStyle) [ text "Select Plan 3" ]
            ]
        , div [ style "padding" "10px 0 10px 0" ]
            [ input [ type_ "checkbox", name "subscribe", onClick ToggleSubscription ] []
            , label [] [ text "Subscribe to Newsletter" ]
            ]
        , div [ style "padding" "10px 0 10px 0" ]
            [ button
                [ style "width" "70px"
                , style "padding" "10px 0 10px 0"
                , style "background-color" "white"
                , style "font-family" "Times New Roman"
                , style "font-weight" "bold"
                , style "border-radius" "5px"
                , style "font-size" "15px"
                , style "border-style" "solid"
                , style "border-color" "black"
                , style "border-width" "thin"
                ]
                [ text "Send" ]
            ]
        ]


inputStyle : List (Attribute msg)
inputStyle =
    [ style "display" "block"
    , style "width" "240px"
    , style "text-align" "center"
    , style "margin" "auto"
    , style "height" "25px"
    ]


planStyle : List (Attribute msg)
planStyle =
    [ style "border-radius" "5px"
    , style "background-color" "white"
    , style "display" "-webkit-inline-box"
    , style "padding" "30px 50px"
    , style "text-align" "-webkit-center"
    , style "margin" "5px"
    ]



{--, hr [] []
        , p [] [ text ("First name is: " ++ model.firstName) ]
        , case model.age of
            Just age ->
                p [] [ text ("Age is: " ++ String.fromInt age) ]

            Nothing ->
                p [] [ text "User has not provided the age" ]
        , p [] [ text ("Information about income: " ++ model.income) ]
        , p [] [ text ("More info: " ++ model.moreInfo) ]
        , case model.gender of
            Just gender ->
                p [] [ text ("Gender: " ++ showGender gender) ]

            Nothing ->
                p [] [ text "User has not provided the gender" ]
        , case model.plan of
            Just plan ->
                p [] [ text ("Plan: " ++ showPlan plan) ]

            Nothing ->
                p [] [ text "User has not provided the plan" ]
        , if model.subscribe then
            p [] [ text "User is subscribed" ]

          else
            p [] [ text "User has not provided subscription" ]
        ]
--}
