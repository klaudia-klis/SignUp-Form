module Main exposing (Days(..), Model, Msg(..), Plan(..), init, main, readPlan, showDays, showPlan, subscriptions, update, view)

import Browser
import Browser.Navigation exposing (pushUrl)
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
    , email : String
    , age : Maybe Int
    , phone : String
    , days : Maybe Days
    , moreInfo : String
    , plan : Maybe Plan
    , subscribe : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            { firstName = ""
            , email = ""
            , age = Nothing
            , phone = ""
            , days = Nothing
            , moreInfo = ""
            , plan = Nothing
            , subscribe = False
            }
    in
    ( model, Cmd.none )


type Days
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday


type Plan
    = Plan1
    | Plan2
    | Plan3
    | Plan4



-- UPDATE


type Msg
    = SetFirstName String
    | SetEmail String
    | SetAge String
    | SetPhone String
    | SetMoreInfo String
    | SetDays String
    | SetPlan String
    | ToggleSubscription


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetFirstName s ->
            ( { model | firstName = s }, Cmd.none )

        SetEmail s ->
            ( { model | email = s }, Cmd.none )

        SetAge s ->
            case String.toInt s of
                Nothing ->
                    ( { model | age = Nothing }, Cmd.none )

                Just n ->
                    ( { model | age = Just n }, Cmd.none )

        SetPhone s ->
            ( { model | phone = s }, Cmd.none )

        SetMoreInfo s ->
            ( { model | moreInfo = s }, Cmd.none )

        SetDays days ->
            ( { model | days = readDays days }, Cmd.none )

        SetPlan plan ->
            ( { model | plan = readPlan plan }, Cmd.none )

        ToggleSubscription ->
            ( { model | subscribe = not model.subscribe }, Cmd.none )


showDays : Days -> String
showDays days =
    case days of
        Monday ->
            "Monday"

        Tuesday ->
            "Tuesday"

        Wednesday ->
            "Wednesday"

        Thursday ->
            "Thursday"

        Friday ->
            "Friday"

        Saturday ->
            "Saturday"

        Sunday ->
            "Sunday"


readDays : String -> Maybe Days
readDays days =
    case days of
        "Monday" ->
            Just Monday

        "Tuesday" ->
            Just Tuesday

        "Wednesday" ->
            Just Wednesday

        "Thursday" ->
            Just Thursday

        "Friday" ->
            Just Friday

        "Saturday" ->
            Just Saturday

        "Sunday" ->
            Just Sunday

        _ ->
            Nothing


showPlan : Plan -> String
showPlan plan =
    case plan of
        Plan1 ->
            "1"

        Plan2 ->
            "2"

        Plan3 ->
            "3"

        Plan4 ->
            "4"


readPlan : String -> Maybe Plan
readPlan plan =
    case plan of
        "1" ->
            Just Plan1

        "2" ->
            Just Plan2

        "3" ->
            Just Plan3

        "4" ->
            Just Plan4

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
        , style "background-color" "#FFFFFF"
        , style "max-width" "700px"
        , style "margin-left" "auto"
        , style "margin-right" "auto"
        , style "margin-top" "20px"
        , style "margin-bottom" "20px"
        , style "font-family" "Gurmukhi MT"
        , style "box-shadow" "0 0 15px 4px rgba(0,0,0,0.06)"
        , style "border-radius" "10px"
        ]
        [ h1
            [ style "padding" "25px 0 25px 0"
            , style "box-shadow" "0 0 15px 4px rgba(0,0,0,0.06)"
            ]
            [ text "Volunteer Application Form" ]
        , p [] [ text "Would you like to join us as a volunteer? Please complete the following form!" ]
        , label [ style "font-weight" "bold" ] [ text "What's your full name?" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ placeholder "Example Name", onInput SetFirstName ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "What's your email address?" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ placeholder "example@email.com", onInput SetEmail ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "What's your age?" ]
        , p
            [ style "margin" "auto"
            , style "font-size" "12px"
            ]
            [ text "(Volunteers must be at least 18 years old)" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ type_ "date", onInput SetAge ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "What's your phone number?" ]
        , div [ style "padding" "10px 0 10px 0" ] [ input ([ placeholder "+(xxx) 111-222-333", onInput SetPhone ] ++ inputStyle) [] ]
        , label [ style "font-weight" "bold" ] [ text "On what days are you available?" ]
        , div
            [ style "padding" "10px 0 20px 0"
            , style "max-width" "500px"
            , style "text-align" "center"
            , style "margin" "auto"
            ]
            [ input [ id "monday", type_ "checkbox", onClick (SetDays (showDays Monday)) ] []
            , label ([ for "monday" ] ++ daysStyle) [ text "Monday" ]
            , input [ id "tuesday", type_ "checkbox", onClick (SetDays (showDays Tuesday)) ] []
            , label ([ for "tuesday" ] ++ daysStyle) [ text "Tuesday" ]
            , br [] []
            , input [ id "wednesday", type_ "checkbox", onClick (SetDays (showDays Wednesday)) ] []
            , label ([ for "wednesday" ] ++ daysStyle) [ text "Wednesday" ]
            , input [ id "thursday", type_ "checkbox", onClick (SetDays (showDays Thursday)) ] []
            , label ([ for "thursday" ] ++ daysStyle) [ text "Thursday" ]
            , br [] []
            , input [ id "friday", type_ "checkbox", onClick (SetDays (showDays Friday)) ] []
            , label ([ for "friday" ] ++ daysStyle) [ text "Friday" ]
            , input [ id "saturday", type_ "checkbox", onClick (SetDays (showDays Saturday)) ] []
            , label ([ for "saturday" ] ++ daysStyle) [ text "Saturday" ]
            , br [] []
            , input [ id "sunday", type_ "checkbox", onClick (SetDays (showDays Sunday)) ] []
            , label ([ for "sunday" ] ++ daysStyle) [ text "Sunday" ]
            ]
        , label [ style "font-weight" "bold" ] [ text "Which time works best for you?" ]
        , div
            [ style "padding" "10px 0 10px 0"
            ]
            [ input [ id "plan1", type_ "checkbox", name "plan", onClick (SetPlan (showPlan Plan1)) ] []
            , label ([ for "plan1" ] ++ planStyle) [ text "10am to 1pm" ]
            , br [] []
            , input [ id "plan2", type_ "checkbox", name "plan", onClick (SetPlan (showPlan Plan2)) ] []
            , label ([ for "plan2" ] ++ planStyle) [ text "1pm to 4pm" ]
            , br [] []
            , input [ id "plan3", type_ "checkbox", name "plan", onClick (SetPlan (showPlan Plan3)) ] []
            , label ([ for "plan3" ] ++ planStyle) [ text "4pm to 7pm" ]
            , br [] []
            , input [ id "plan4", type_ "checkbox", name "plan", onClick (SetPlan (showPlan Plan4)) ] []
            , label ([ for "plan4" ] ++ planStyle) [ text "7pm to 10pm" ]
            ]
        , label [ style "font-weight" "bold" ] [ text "More info" ]
        , div [ style "padding" "10px 0 10px 0" ] [ textarea ([ placeholder "Tell us more about yourself!", onInput SetMoreInfo ] ++ inputStyle) [] ]
        , div [ style "padding" "10px 0 10px 0px" ]
            [ input [ type_ "checkbox", name "subscribe", onClick ToggleSubscription ] []
            , label [ style "margin" "0 20px 10px 5px" ] [ text "Confirm that all the infromation given above are true and complete." ]
            ]
        , div [ style "padding" "10px 0 10px 0" ]
            [ button
                [ style "padding" "10px"
                , style "background" "white"
                , style "border" "none"
                , style "box-shadow" "0 6px 20px 0 rgba(0,0,0,0.19), 0 6px 20px 0 rgba(0,0,0,0.19)"
                , style "font-family" "Gurmukhi MT"
                , style "width" "90px"
                , style "font-size" "14px"
                , style "font-weight" "bold"
                ]
                [ text "Send" ]
            ]
        ]


inputStyle : List (Attribute msg)
inputStyle =
    [ style "display" "block"
    , style "width" "240px"
    , style "text-align" "left"
    , style "margin" "auto"
    , style "height" "25px"
    , style "background-color" "#FFFFFF"
    , style "border-top-width" "0"
    , style "border-left-width" "0"
    , style "border-right-width" "0"
    , style "border-bottom-width" "1px"
    , style "border-color" "black"
    ]


planStyle : List (Attribute msg)
planStyle =
    [ style "margin" "0 20px 10px 5px"
    , style "box-shadow" "0 0 15px 4px rgba(0,0,0,0.06)"
    , style "padding" "10px"
    , style "text-align" "-webkit-center"
    , style "display" "-webkit-inline-box"
    , style "font-size" "14px"
    , style "width" "90px"
    , style "height" "20px"
    ]


daysStyle : List (Attribute msg)
daysStyle =
    [ style "margin" "0 20px 10px 5px"
    , style "box-shadow" "0 0 15px 4px rgba(0,0,0,0.06)"
    , style "padding" "10px"
    , style "text-align" "-webkit-center"
    , style "width" "70px"
    , style "height" "20px"
    , style "font-size" "14px"
    , style "display" "-webkit-inline-box"
    ]



{--, hr [] []
        , p [] [ text ("Full name is: " ++ model.fullName) ]
        , p [] [ text ("Email address is: " ++ model.email) ]
        , case model.age of
            Just age ->
                p [] [ text ("Age is: " ++ String.fromInt age) ]

            Nothing ->
                p [] [ text "User has not provided the age" ]
        , p [] [ text ("Phone number: " ++ model.phone) ]
        , case model.days of
            Just days ->
                p [] [ text ("Days availability: " ++ showDays days) ]

            Nothing ->
                p [] [ text "User has not provided the days availability" ]
        , case model.plan of
            Just plan ->
                p [] [ text ("Time availability: " ++ showPlan plan) ]

            Nothing ->
                p [] [ text "User has not provided the time availability" ]
        , p [] [ text ("More info: " ++ model.moreInfo) ]
        , if model.subscribe then
            p [] [ text "User confirmed." ]

          else
            p [] [ text "User didn't confrim." ]
        ]
--}
