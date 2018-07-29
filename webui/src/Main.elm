module Main exposing (..)

import Html exposing (Html)
import Html.Attributes as Attrs
import Html.Events as Events


---- MODEL ----


type View
    = Documents
    | Unfiled
    | Tags


type Tag
    = TUnfiled
    | TCustom String


type alias Document =
    { date : String
    , name : String
    , tags : List Tag
    }


type alias Model =
    { searchVisible : Bool
    , currentView : View
    , documents : List Document
    }


testDocuments =
    [ Document "2018-04-20" "Hack-N-Tel Mockups" [ TCustom "papertrail", TCustom "mockups" ]
    , Document "2018-04-18" "Water Bill" [ TCustom "utilities", TCustom "invoice" ]
    , Document "2018-04-18" "Medical Bill" [ TCustom "health", TCustom "invoice" ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unfiled" [ TUnfiled ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    , Document "0000-00-00" "Unkown" [ TCustom "unkown" ]
    ]


init : ( Model, Cmd Msg )
init =
    ( { searchVisible = False
      , currentView = Documents
      -- , documents = []
      , documents = testDocuments
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp
    | ShowSearch Bool
    | SetView View


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        ShowSearch visible ->
            ( { model | searchVisible = visible }, Cmd.none )
        SetView newView ->
            ( { model | currentView = newView }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view { searchVisible, currentView, documents } =
    Html.div [ Attrs.class "view" ]
             [ menu searchVisible currentView
             , case currentView of
                 Documents ->
                     documentsView (List.filter filedDocument documents)
                 Unfiled ->
                     unfiledDocuments (List.filter unfiledDocument documents)
                 Tags ->
                     tags
             ]


filedDocument : Document -> Bool
filedDocument { tags } =
    not <| List.any (\t -> case t of
                        TUnfiled ->
                            True
                        TCustom _ ->
                            False
             )
             tags




unfiledDocument : Document -> Bool
unfiledDocument { tags } =
    List.any (\t -> case t of
               TUnfiled ->
                   True
               TCustom _ ->
                   False
    )
    tags


menu : Bool -> View -> Html Msg
menu searchVisible currentView =
    Html.nav []
             [ navButton currentView Documents "papertrail" "logo"
             , navButton currentView Unfiled "Unfiled" ""
             , navButton currentView Tags "Tags" ""
             , search searchVisible
             ]


navButton : View -> View -> String -> String -> Html Msg
navButton currentView setView text class =
    Html.button [ Events.onClick (SetView setView)
                , Attrs.class ("navigate " ++ class ++ if currentView == setView then " current-view" else "")
                ]
                [ Html.text text ]


search : Bool -> Html Msg
search visible =
    Html.div [ Attrs.class "search" ]
             [ Html.button [ Events.onClick (ShowSearch (not visible)) ]
                           [ Html.text "Search" ]
             , (if visible then searchModal else Html.text "")
             ]


searchModal : Html Msg
searchModal =
    Html.div [ Attrs.class "search__modal"
             , Events.onClick (ShowSearch False)
             ]
             [ Html.input [ Attrs.class "search__modal__input" ] [] ]


documentsView : List Document -> Html Msg
documentsView documents =
    Html.div [ Attrs.class "content documents" ]
             [ Html.button [ Attrs.class "documents__add-button" ] [ Html.text "+ Add Document" ]
             , documentListHeader
             , documentList documents
             ]


documentListHeader =
    Html.div [ Attrs.class "document-list__header" ]
               [ Html.div [] [ Html.text "Date" ]
               , Html.div [] [ Html.text "Name" ]
               , Html.div [] [ Html.text "Tags" ]
               , Html.div [] []
               ]

documentList : List Document -> Html Msg
documentList documents =
    Html.ul [ Attrs.class "document-list__body" ]
              <| List.map documentView documents


documentView : Document -> Html Msg
documentView { date, name, tags } =
    Html.li [ Attrs.class "document-list__body__document" ]
            [ Html.div [ Attrs.class "document-list__body__document__column" ] [ Html.text date ]
            , Html.div [ Attrs.class "document-list__body__document__column" ] [ Html.text name ]
            , Html.div [ Attrs.class "document-list__body__document__column" ] [ Html.text "tags" ]
            , Html.div [ Attrs.class "document-list__body__document__column" ] [ Html.button [] [ Html.text "???" ] ]
            ]


unfiledDocuments : List Document -> Html Msg
unfiledDocuments documents =
    Html.div [ Attrs.class "content unfiled-documents" ]
             [ documentListHeader
             , documentList documents
             ]


tags : Html Msg
tags =
    Html.div [ Attrs.class "content" ]
             [ Html.text "Tags" ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
